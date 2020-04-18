PROMPT '5th rule - 5_percent_promo scheduler job'
BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        JOB_NAME        => '5_percent_promo',
        JOB_TYPE        => 'PLSQL_BLOCK',
        JOB_ACTION      => '',
        START_DATE      => SYSTIMESTAMP,
        REPEAT_INTERVAL => 'FREQ=WEEKLY; BYDAY=MON; BYHOUR=07; BYMINUTE=00',
        END_DATE        => NULL,
        ENABLED         => TRUE);
    );
END;
/