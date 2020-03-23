-- ZESTAW SZYMON KONOPKA

-- ZESTAW GRZEGORZ STALA

-- QUERY 1
select G.GENERATIONNAME, AVG(S.LINEITEMAMOUNT) from CUSTOMER C
    join GENERATION G on C.BIRTHYEAR = G.BIRTHYEAR
    join SALESRECIEPTS S on C.ID = S.CUSTOMER
group by G.GENERATIONNAME;

-- QUERY 3
select * from (
select P.ID, P.PRODUCTCATEGORY, PY.WASTEPERCENTAGE, D.TRANSACTIONDATE, 'GOOD' as status from GRZEGORZ.PRODUCT P
    join GRZEGORZ.PASTRYINVENTORY PY on P.ID = PY.PRODUCT
    join DATES D on PY.TRANSACTIONDATE = D.TRANSACTIONDATE
    order BY PY.WASTEPERCENTAGE) res1 where res1.TRANSACTIONDATE < to_date('05-04-19','DD-MM-YY') AND ROWNUM <= 10
union
select * from (
select P.ID, P.PRODUCTCATEGORY, PY.WASTEPERCENTAGE, D.TRANSACTIONDATE, 'BAD' as status from GRZEGORZ.PRODUCT P
    join GRZEGORZ.PASTRYINVENTORY PY on P.ID = PY.PRODUCT
    join DATES D on PY.TRANSACTIONDATE = D.TRANSACTIONDATE
    order BY PY.WASTEPERCENTAGE DESC) res2  where res2.TRANSACTIONDATE < to_date('05-04-19','DD-MM-YY') AND ROWNUM <= 10;

-- QUERY 4
select * from (
select S.ID, S.FIRSTNAME, s.LASTNAME, p.NAME, COUNT(*) as sales, 'BAD' as status from STAFF s
    join POSITION p on s.POSITION = p.ID
    join SALESRECIEPTS sr on s.ID = sr.STAFF
    join dates d on sr.TRANSACTIONDATE = d.TRANSACTIONDATE
    group by s.ID, s.FIRSTNAME, s.LASTNAME, p.NAME order by COUNT(*)) res1 where ROWNUM <= 10
union
select * from (
select S.ID, S.FIRSTNAME, s.LASTNAME, p.NAME, COUNT(*) as sales, 'GOOD' as status from STAFF s
    join POSITION p on s.POSITION = p.ID
    join SALESRECIEPTS sr on s.ID = sr.STAFF
    join dates d on sr.TRANSACTIONDATE = d.TRANSACTIONDATE
    group by s.ID, s.FIRSTNAME, s.LASTNAME, p.NAME order by COUNT(*) DESC) res2 where ROWNUM <= 10;

-- ZESTAW JAKUB STEPANIAK