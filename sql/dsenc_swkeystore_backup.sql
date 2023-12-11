--------------------------------------------------------------------------------
--  OraDBA - Oracle Database Infrastructur and Security, 5630 Muri, Switzerland
--------------------------------------------------------------------------------
--  Name......: dsenc_swkeystore_backup.sql
--  Author....: Stefan Oehrli (oes) stefan.oehrli@oradba.ch
--  Editor....: Stefan Oehrli
--  Date......: 2023.12.09
--  Revision..:  
--  Purpose...: Delete TDE software keystore backup jobs
--  Notes.....:  
--  Reference.: Requires SYS, SYSDBA or SYSKM privilege
--  License...: Apache License Version 2.0, January 2004 as shown
--              at http://www.apache.org/licenses/
--------------------------------------------------------------------------------
-- format SQLPlus output and behavior
SET LINESIZE 160 PAGESIZE 200
SET FEEDBACK ON
SET SERVEROUTPUT ON

-- start to spool
SPOOL dsenc_swkeystore_backup.log
BEGIN
    dbms_scheduler.drop_job(job_name           => 'TDE_Backup_Job');
    dbms_scheduler.drop_schedule(schedule_name => 'TDE_Backup_Schedule');
    dbms_scheduler.drop_program(program_name   => 'TDE_Backup_Keystore');

    dbms_output.put_line('INFO : Scheduler Job for TDE software Keystore Backup deleted.');
END;
/

SPOOL OFF
-- EOF -------------------------------------------------------------------------