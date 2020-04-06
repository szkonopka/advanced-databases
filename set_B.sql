-- ZESTAW GRZEGORZ STALA

alter system flush buffer_cache;
alter system flush shared_pool;
set autotrace traceonly statistics
alter session set NLS_TIMESTAMP_FORMAT = 'HH:MI:SS.FF6';
set timing on

-- QUERY 1
prompt '1st QUERY'
select G.GENERATIONNAME, ROUND(AVG(S.LINEITEMAMOUNT),2) as avgLineItemAmount from CUSTOMER C
    join GENERATION G on C.BIRTHYEAR = G.BIRTHYEAR
    join SALESRECIEPTS S on C.ID = S.CUSTOMER
group by G.GENERATIONNAME;

-- QUERY 2
prompt '2nd QUERY'
select * from (
select s.ID, s.FIRSTNAME, s.LASTNAME, p.NAME,so.STORECITY, SUM(round(pi.waste * sr.LINEITEMAMOUNT, 2)) as waste, 'GOOD' as status from STAFF s
    join POSITION p on s.POSITION = p.ID
    join SALESOUTLET so on s.ID = so.MANAGER
    join SALESRECIEPTS sr on so.ID = sr.SALESOUTLET
    join dates on sr.TRANSACTIONDATE = DATES.TRANSACTIONDATE
    join PASTRYINVENTORY pi on DATES.TRANSACTIONDATE = pi.TRANSACTIONDATE
    join PRODUCT on pi.PRODUCT = PRODUCT.ID AND sr.PRODUCT = PRODUCT.ID
    WHERE months_between(sysdate, SR.TRANSACTIONDATE) < 1000
    group by s.ID, s.FIRSTNAME, s.LASTNAME, p.NAME, so.STORECITY
    order by WASTE) where ROWNUM <= 50
union
select * from (
select s.ID, s.FIRSTNAME, s.LASTNAME, p.NAME,so.STORECITY, SUM(round(pi.waste * sr.LINEITEMAMOUNT, 2)) as waste, 'BAD' as status from STAFF s
    join POSITION p on s.POSITION = p.ID
    join SALESOUTLET so on s.ID = so.MANAGER
    join SALESRECIEPTS sr on so.ID = sr.SALESOUTLET
    join dates on sr.TRANSACTIONDATE = DATES.TRANSACTIONDATE
    join PASTRYINVENTORY pi on DATES.TRANSACTIONDATE = pi.TRANSACTIONDATE
    join PRODUCT on pi.PRODUCT = PRODUCT.ID AND sr.PRODUCT = PRODUCT.ID
    WHERE months_between(sysdate, SR.TRANSACTIONDATE) < 1000
    group by s.ID, s.FIRSTNAME, s.LASTNAME, p.NAME, so.STORECITY
    order by WASTE DESC) where ROWNUM <= 50;

-- QUERY 3
prompt '3rd QUERY'
select * from (
select P.ID, P.PRODUCTCATEGORY, PY.WASTEPERCENTAGE, D.TRANSACTIONDATE, 'GOOD' as status from PRODUCT P
    join PASTRYINVENTORY PY on P.ID = PY.PRODUCT
    join DATES D on PY.TRANSACTIONDATE = D.TRANSACTIONDATE
    order BY PY.WASTEPERCENTAGE) res1 where months_between(sysdate, res1.TRANSACTIONDATE) < 1000 AND ROWNUM <= 50
union
select * from (
select P.ID, P.PRODUCTCATEGORY, PY.WASTEPERCENTAGE, D.TRANSACTIONDATE, 'BAD' as status from PRODUCT P
    join PASTRYINVENTORY PY on P.ID = PY.PRODUCT
    join DATES D on PY.TRANSACTIONDATE = D.TRANSACTIONDATE
    order BY PY.WASTEPERCENTAGE DESC) res2  where months_between(sysdate, res2.TRANSACTIONDATE) < 1000 AND ROWNUM <= 50;

-- QUERY 4
prompt '4th QUERY'
select * from (
select S.ID, S.FIRSTNAME, s.LASTNAME, p.NAME, COUNT(*) as sales, 'BAD' as status from STAFF s
    join POSITION p on s.POSITION = p.ID
    join SALESRECIEPTS sr on s.ID = sr.STAFF
    join dates d on sr.TRANSACTIONDATE = d.TRANSACTIONDATE
    group by s.ID, s.FIRSTNAME, s.LASTNAME, p.NAME order by COUNT(*)) res1 where ROWNUM <= 50
union
select * from (
select S.ID, S.FIRSTNAME, s.LASTNAME, p.NAME, COUNT(*) as sales, 'GOOD' as status from STAFF s
    join POSITION p on s.POSITION = p.ID
    join SALESRECIEPTS sr on s.ID = sr.STAFF
    join dates d on sr.TRANSACTIONDATE = d.TRANSACTIONDATE
    group by s.ID, s.FIRSTNAME, s.LASTNAME, p.NAME order by COUNT(*) DESC) res2 where ROWNUM <= 50;

-- QUERY 5
prompt '5th QUERY'
select cus.id, cus.FIRSTNAME, g.GENERATIONNAME, so.ID as salesOutletId, COUNT(*) as sales, SUM(sr.LINEITEMAMOUNT) as total from CUSTOMER cus
    join SALESRECIEPTS sr on cus.ID = sr.CUSTOMER
    join SALESOUTLET so on sr.SALESOUTLET = so.ID
    join GENERATION G on cus.BIRTHYEAR = G.BIRTHYEAR
    where months_between(sysdate, sr.TRANSACTIONDATE) < 1000 and ROWNUM <= 50
    group by cus.ID, cus.FIRSTNAME, g.GENERATIONNAME, so.ID order by SUM(sr.LINEITEMAMOUNT) DESC ;

-- COMMAND 1
prompt '1st COMMAND'
update STAFF
    set POSITION = (select id from POSITION where NAME like 'CEO%')
    where ID in (
        select * from (
select st.ID from staff st
    join SALESRECIEPTS sr on st.ID = sr.STAFF
    WHERE months_between(sysdate, SR.TRANSACTIONDATE) < 1000
    group by st.ID, st.FIRSTNAME, st.LASTNAME
    order by count(*) DESC) where ROWNUM <= 50
            );

-- COMMAND 2
prompt '2nd COMMAND'
update PRODUCT set CURRENTRETAILPRICE = CURRENTRETAILPRICE + CURRENTRETAILPRICE * 0.05 
    where ID in (select distinct p.id from PRODUCT p
    join SALESRECIEPTS sr on p.ID = sr.PRODUCT
    join PRODUCTCATEGORY pc on p.PRODUCTCATEGORY = pc.ID
    join SALESOUTLET so on sr.SALESOUTLET = so.ID
    join PASTRYINVENTORY pi on p.ID = pi.PRODUCT
    where pc.CATEGORY = 'Coffee beans' and so.ID = 1 and WASTEPERCENTAGE < 50);

exit rollback