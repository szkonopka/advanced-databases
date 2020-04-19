
alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics

@triggers/trigger_2.sql

timing start trigger_2

begin
    dbms_scheduler.run_job(job_name => 'sales_statement');
end;
/

timing stop   
exit rollback