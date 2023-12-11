--------------------------------------------------------------------------------
--  OraDBA - Oracle Database Infrastructur and Security, 5630 Muri, Switzerland
--------------------------------------------------------------------------------
--  Name......: csenc_swkeystore_backup.sql
--  Author....: Stefan Oehrli (oes) stefan.oehrli@oradba.ch
--  Editor....: Stefan Oehrli
--  Date......: 2023.12.09
--  Revision..:  
--  Purpose...: Create TDE software keystore backup
--  Notes.....:  
--  Reference.: Requires SYS, SYSDBA or SYSKM privilege
--  License...: Apache License Version 2.0, January 2004 as shown
--              at http://www.apache.org/licenses/
--------------------------------------------------------------------------------

-- define default values
DEFINE def_backup_dir   = 'backup'
DEFINE def_backup_path  = ''

-- assign default value for parameter if argument 1 and 2 if one is empty
SET FEEDBACK OFF
SET VERIFY OFF
-- Assign default value for parameter 1 backup_dir
COLUMN 1 NEW_VALUE 1 NOPRINT
SELECT '' "1" FROM dual WHERE ROWNUM = 0;
COLUMN def_backup_dir NEW_VALUE def_backup_dir NOPRINT
DEFINE backup_dir                 = &1 &def_backup_dir

-- Assign default value for parameter 2 backup_path
COLUMN 2 NEW_VALUE 2 NOPRINT
SELECT '' "2" FROM dual WHERE ROWNUM = 0;
COLUMN def_backup_path NEW_VALUE def_backup_path NOPRINT
DEFINE backup_path                 = &1 &def_backup_path

SET FEEDBACK OFF
SET VERIFY OFF
-- define default values
COLUMN wallet_root NEW_VALUE wallet_root NOPRINT

-- format SQLPlus output and behavior
SET LINESIZE 160 PAGESIZE 200
SET FEEDBACK ON
SET SERVEROUTPUT ON

COLUMN wrl_type         FORMAT A8
COLUMN wrl_parameter    FORMAT A75
COLUMN status           FORMAT A18
COLUMN wallet_type      FORMAT A15
COLUMN con_id           FORMAT 99999

-- start to spool
SPOOL csenc_swkeystore_backup.log

BEGIN
-- create program TDE_Backup_Keystore to backup the TDE software keystore
    dbms_scheduler.create_program (
        program_name   => 'TDE_Backup_Keystore',
        program_type   => 'PLSQL_BLOCK',
        program_action => q'(
            DECLARE
                v_tag         VARCHAR2(30)  := 'BackupJob';
                v_backup_dir  VARCHAR2(30)  := '&backup_dir';
                v_backup_path VARCHAR2(128) := '&backup_path';
            BEGIN
                IF v_backup_path IS NULL THEN
                SELECT value INTO v_backup_path
                FROM v$parameter
                WHERE name = 'wallet_root';
                
                v_backup_path := v_backup_path
                                || '/'
                                || v_backup_dir;
                END IF;
                EXECUTE IMMEDIATE 'ADMINISTER KEY MANAGEMENT 
                    BACKUP KEYSTORE USING "'
                                    || v_tag
                                    || '" FORCE KEYSTORE
                    IDENTIFIED BY EXTERNAL STORE TO '''
                                    || v_backup_path
                                    || ''' ';
                END;
            )',
            enabled   => TRUE,
            comments  => 'Program to create a TDE Keystore backup using PL/SQL block.'); 

-- create schedule TDE_Backup_Schedule to backup the TDE software keystore
    dbms_scheduler.create_schedule (
        schedule_name   => 'TDE_Backup_Schedule',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'freq=weekly; byday=fri; byhour=12; byminute=0; bysecond=0;',
        end_date        => NULL,
        comments        => 'TDE schedule, repeats weekly on Friday at 12:00 for ever.');

-- create job TDE_Backup_Job to backup the TDE software keystore
    dbms_scheduler.create_job (
        job_name      => 'TDE_Backup_Job',
        program_name  => 'TDE_Backup_Keystore',
        schedule_name => 'TDE_Backup_Schedule',
        enabled       => TRUE,
        comments      => 'TDE backup job using program TDE_BACKUP_KEYSTORE and schedule TDE_BACKUP_SCHEDULE.');

    dbms_output.put_line('INFO : Scheduler Job for TDE software Keystore Backup created.');
    dbms_output.put_line('INFO : Dont forget to create directory &backup_path/&backup_dir');
END;
/

SPOOL OFF
-- EOF -------------------------------------------------------------------------
