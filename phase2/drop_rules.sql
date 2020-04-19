-- DELETE TRIGGERS - RULES: 3, 4, 6, 7
DROP TRIGGER sold_products;
DROP TRIGGER check_stack_before_transaction;
DROP TRIGGER delete_sales_outlet;
DROP TRIGGER sales_goals_for_new_sales_outlet;

-- DELETE SCHEDULER JOBS - RULES: 1, 2, 5, 8, 9
BEGIN
    DBMS_SCHEDULER.DROP_JOB('unsold_products');
END;
/

BEGIN
    DBMS_SCHEDULER.DROP_JOB('sales_statement');
END;
/

BEGIN
    DBMS_SCHEDULER.DROP_JOB('5_percent_promo');
END;
/

BEGIN
    DBMS_SCHEDULER.DROP_JOB('employee_promotion');
END;
/

BEGIN
    DBMS_SCHEDULER.DROP_JOB('goals_update');
END;
/

EXIT;