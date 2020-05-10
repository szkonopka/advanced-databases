TIMING START no_xml_timing;

select * from (
select S.ID, S.FIRST_NAME, s.LAST_NAME, p.NAME, COUNT(*) as sales, 'BAD' as status from STAFF s
    join POSITION p on s.POSITION_ID = p.ID
    join SALES_RECEIPT sr on s.ID = sr.STAFF_ID
    group by s.ID, s.FIRST_NAME, s.LAST_NAME, p.NAME order by COUNT(*)) res1 where ROWNUM <= 50
union
select * from (
select S.ID, S.FIRST_NAME, s.LAST_NAME, p.NAME, COUNT(*) as sales, 'GOOD' as status from STAFF s
    join POSITION p on s.POSITION_ID = p.ID
    join SALES_RECEIPT sr on s.ID = sr.STAFF_ID
    group by s.ID, s.FIRST_NAME, s.LAST_NAME, p.NAME order by COUNT(*) DESC) res2 where ROWNUM <= 50;

TIMING STOP;
EXIT ROLLBACK;