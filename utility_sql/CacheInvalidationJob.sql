-- Get Active instance of DynaCacheInvalidation Job

SELECT T1.SCCHOST, T1.SCCSTART, T1.STOREENT_ID, T1.SCCPRIORITY, T1.SCCSEQUENCE, T1.SCCRECDELAY, T1.SCCJOBREFNUM, T1.SCCACTIVE, T1.SCCRECATT, T1.SCCAPPTYPE, T1.SCCPATHINFO, T1.MEMBER_ID, T1.SCCQUERY, T1.INTERFACENAME, T1.SCCINTERVAL, T1.OPTCOUNTER FROM SCHCONFIG  T1 WHERE t1.sccpathinfo='DynaCacheInvalidation' and t1.SCCACTIVE='A'

-- Get history of DynaCacheInvalidation Job execution
select * from SCHSTATUS WHERE SCSJOBNBR IN 
(SELECT SCCJOBREFNUM FROM SCHCONFIG  WHERE sccpathinfo='DynaCacheInvalidation' and SCCACTIVE='A') ;

-- Get time of next execution of DynaCacheInvalidation Job
select * from SCHSTATUS WHERE SCSJOBNBR IN 
(SELECT SCCJOBREFNUM FROM SCHCONFIG  WHERE sccpathinfo='DynaCacheInvalidation' and SCCACTIVE='A') 
order by SCSACTLSTART desc;

