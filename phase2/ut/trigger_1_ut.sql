
alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics

@triggers/trigger_1.sql

timing start trigger_1

begin
    dbms_scheduler.run_job(job_name => 'unsold_products');
end;
/

timing stop   
exit rollback