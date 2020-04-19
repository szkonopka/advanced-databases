PROMPT '9th rule - goals_update scheduler job'
BEGIN
    DBMS_SCHEDULER.CREATE_JOB(
            JOB_NAME   => 'goals_update',
            JOB_TYPE   => 'PLSQL_BLOCK',
            JOB_ACTION => '',
            START_DATE      => SYSTIMESTAMP,
            REPEAT_INTERVAL => 'FREQ=MONTHLY; BYMONTHDAY=-1;',
            END_DATE        => NULL,
            ENABLED         => TRUE);
END;
/
