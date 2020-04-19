
alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics

@triggers/trigger_5.sql

timing start trigger_5

begin
    dbms_scheduler.run_job(job_name => '5_percent_promo');
end;
/

timing stop   
exit rollback