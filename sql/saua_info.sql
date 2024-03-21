DECLARE
    -- Variables for chunk handling
    v_chunk_size_gb NUMBER := 1; -- Specify chunk size here in GB
    v_chunk_size_bytes NUMBER;
    v_excluded_tablespace VARCHAR2(100) := 'SYSTEM'; -- Specify excluded tablespace name here

    -- Cursor to fetch file names for each chunk
    CURSOR c_file_names(p_chunk_id NUMBER) IS
        WITH FileSizes AS (
            SELECT df.name, df.bytes,
                   SUM(df.bytes) OVER (ORDER BY df.bytes DESC) AS cumulative_size,
                   CASE WHEN df.bytes > v_chunk_size_bytes THEN 1 ELSE 0 END AS is_large_file,
                   df.ts#,
                   ts.name as tablespace_name
            FROM v$datafile df
            JOIN v$tablespace ts ON df.ts# = ts.ts#
            WHERE ts.name != v_excluded_tablespace
        ),
        ChunkedFiles AS (
            SELECT name, bytes, is_large_file,
                   CASE WHEN is_large_file = 1 THEN ROW_NUMBER() OVER (ORDER BY bytes DESC)
                        ELSE FLOOR((cumulative_size - 1) / v_chunk_size_bytes) + 1 END AS chunk_id
            FROM FileSizes
        )
        SELECT name
        FROM ChunkedFiles
        WHERE chunk_id = p_chunk_id
        ORDER BY bytes DESC;
BEGIN
    -- Convert chunk size from GB to bytes
    v_chunk_size_bytes := v_chunk_size_gb * 1024 * 1024 * 1024;

    -- Loop to process chunks and list file names
    FOR r_chunk IN (
        SELECT chunk_id, 
               CASE WHEN MAX(is_large_file) = 1 THEN 'Large File Chunk' ELSE 'Regular Chunk' END AS chunk_type,
               COUNT(name) AS files_in_chunk,
               SUM(bytes) AS total_size_in_chunk
        FROM ChunkedFiles
        GROUP BY chunk_id
        ORDER BY chunk_id
    ) LOOP
        -- Print chunk header
        DBMS_OUTPUT.PUT_LINE('-- Chunk ' || r_chunk.chunk_id || ' ' || r_chunk.chunk_type || 
                             ' with ' || r_chunk.files_in_chunk || ' files and a total size of ' || 
                             r_chunk.total_size_in_chunk);
        -- Nested loop to print each file name in the current chunk
        FOR r_file IN c_file_names(r_chunk.chunk_id) LOOP
            DBMS_OUTPUT.PUT_LINE(r_file.name);
        END LOOP;
    END LOOP;
END;
/