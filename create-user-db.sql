-- LOG IN INTO SYSTEM ACCOUNT AND EXECUTE --
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
CREATE USER coffeeshop IDENTIFIED BY pass;
GRANT CONNECT, RESOURCE, DBA TO coffeeshop;
EXIT
