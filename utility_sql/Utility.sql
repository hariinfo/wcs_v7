-- Oracle Utility SQL

-- Use this sql to get the schema definition
select DBMS_METADATA.GET_DDL('TABLE','CTXMGMT') from DUAL;

select DBMS_METADATA.GET_DDL('TABLE','PPCPAYINST') from DUAL;

select dbms_metadata.get_ddl('INDEX', 'I0000831') from dual


-- Use this query to get schema name and total size from DB
select 
owner SchemaName, 
round(sum(bytes)/1024/1024/1024,2) TotalSizeGB 
from dba_segments 
group by owner 
order by 2 desc 

--- Tablespace status
SELECT /* + RULE */  df.tablespace_name "Tablespace",
       df.bytes / (1024 * 1024) "Size (MB)",
       SUM(fs.bytes) / (1024 * 1024) "Free (MB)",
       Nvl(Round(SUM(fs.bytes) * 100 / df.bytes),1) "% Free",
       Round((df.bytes - SUM(fs.bytes)) * 100 / df.bytes) "% Used"
  FROM dba_free_space fs,
       (SELECT tablespace_name,SUM(bytes) bytes
          FROM dba_data_files
         GROUP BY tablespace_name) df
 WHERE fs.tablespace_name (+)  = df.tablespace_name
 GROUP BY df.tablespace_name,df.bytes
UNION ALL
SELECT /* + RULE */ df.tablespace_name tspace,
       fs.bytes / (1024 * 1024),
       SUM(df.bytes_free) / (1024 * 1024),
       Nvl(Round((SUM(fs.bytes) - df.bytes_used) * 100 / fs.bytes), 1),
       Round((SUM(fs.bytes) - df.bytes_free) * 100 / fs.bytes)
  FROM dba_temp_files fs,
       (SELECT tablespace_name,bytes_free,bytes_used
          FROM v$temp_space_header
         GROUP BY tablespace_name,bytes_free,bytes_used) df
 WHERE fs.tablespace_name (+)  = df.tablespace_name
 GROUP BY df.tablespace_name,fs.bytes,df.bytes_free,df.bytes_used
 ORDER BY 4 DESC;
 
 
 -- Use this SQL to identify the cause of blocker
      SELECT count(*), event
 FROM v$session_wait
 WHERE wait_time = 0
  AND event NOT IN ('smon timer','pmon timer','rdbms ipc message', 
     'SQL*Net message from client')
 GROUP BY event
 ORDER BY 1 DESC;
 
 -- Frequency of my redo log switching through a SQL query. 
 --COL DAY FORMAT a15;
 --COL HOUR FORMAT a4;
 --COL TOTAL FORMAT 999;
 SELECT TO_CHAR(FIRST_TIME,'YYYY-MM-DD') DAY,
 TO_CHAR(FIRST_TIME,'HH24') HOUR,
 COUNT(*) TOTAL
 FROM V$LOG_HISTORY
 GROUP BY TO_CHAR(FIRST_TIME,'YYYY-MM-DD'),TO_CHAR(FIRST_TIME,'HH24')
 ORDER BY TO_CHAR(FIRST_TIME,'YYYY-MM-DD'),TO_CHAR(FIRST_TIME,'HH24')
 ASC;
 
 
-- SQL to identify Holders and Blockers.
SELECT substr(DECODE(request,0,'Holder: ','Waiter: ')||sid,1,12) sess,
       id1, id2, lmode, request, type, inst_id
 FROM GV$LOCK
WHERE (id1, id2, type) IN
   (SELECT id1, id2, type FROM GV$LOCK WHERE request>0)
     ORDER BY id1, request


