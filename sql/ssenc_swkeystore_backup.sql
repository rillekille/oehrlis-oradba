--------------------------------------------------------------------------------
--  OraDBA - Oracle Database Infrastructur and Security, 5630 Muri, Switzerland
--------------------------------------------------------------------------------
--  Name......: ssenc_swkeystore_backup.sql
--  Author....: Stefan Oehrli (oes) stefan.oehrli@oradba.ch
--  Editor....: Stefan Oehrli
--  Date......: 2023.12.09
--  Revision..:  
--  Purpose...: Show TDE software keystore backup
--  Notes.....:  
--  Reference.: Requires SYS, SYSDBA or SYSKM privilege
--  License...: Apache License Version 2.0, January 2004 as shown
--              at http://www.apache.org/licenses/
--------------------------------------------------------------------------------

-- format SQLPlus output and behavior
SET LINESIZE 160 PAGESIZE 200
SET FEEDBACK ON
SET SERVEROUTPUT ON

COLUMN program_name     FORMAT A20
COLUMN schedule_name    FORMAT A20
COLUMN job_name         FORMAT A20
COLUMN start_date       FORMAT A35
COLUMN repeat_interval  FORMAT A60
COLUMN comments         FORMAT A60
COLUMN last_start_date  FORMAT A20
COLUMN next_run_date    FORMAT A20
ALTER SESSION SET nls_timestamp_tz_format='DD.MM.YYYY HH24:MI:SS';

-- start to spool
SPOOL ssenc_swkeystore_backup.log

-- scheduler program
SELECT program_name, program_type, enabled,comments 
FROM user_scheduler_programs WHERE program_name LIKE 'TDE%';

-- scheduler schedul
SELECT schedule_name, start_date, repeat_interval, comments FROM user_scheduler_schedules
WHERE schedule_name LIKE 'TDE%';

-- scheduler job
SELECT job_name, program_name, schedule_name, enabled, state,
       run_count, last_start_date, next_run_date
FROM user_scheduler_jobs WHERE job_name LIKE 'TDE%';

SPOOL OFF
-- EOF -------------------------------------------------------------------------