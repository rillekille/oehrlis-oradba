CREATE AUDIT POLICY oradba_loc_logon_events_scott
    ACTIONS
    LOGON,
    LOGOFF
    WHEN '(sys_context(''userenv'',''session_user'')=''SCOTT'')' EVALUATE PER SESSION;
AUDIT POLICY oradba_loc_logon_events_scott;

CREATE AUDIT POLICY oradba_loc_logon_events2_scott
    ACTIONS
    LOGON,
    LOGOFF
    WHEN '(sys_context(''userenv'',''current_user'')=''SCOTT'')' EVALUATE PER SESSION;
AUDIT POLICY oradba_loc_logon_events2_scott;


CREATE AUDIT POLICY oradba_loc_logon_events3_scott
    ACTIONS
    LOGON,
    LOGOFF;

AUDIT POLICY oradba_loc_logon_events3_scott BY SCOTT;