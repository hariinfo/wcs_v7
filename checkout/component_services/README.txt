** com.ibm.commerce.messaging.outboundservice.SendTransactedMessage
This command is used by WCS OOB Job SendTransactedMsg
select * from schconfig where sccpathinfo = 'SendTransactedMsg'
and sccactive='A';

Default Behaviour:
This Job runs every 5 minutes and will process records in MSGSTORE table, this table consists of data which use Asynch.
mode of transmitting data to the backend system.
msg.sendTransacted()

This job uses EJB access bean delete technique once the record is processed successfully,
public void afterSuccess()
…
CurrBean.getEJBRef().remove();

If message is not transmitted, it does not delete the message, instead it will decrement the MSGSTORE. Retries (default is 3), it will retry the same message until MSGSTORE. Retries is 0.
Messages with MSGSTORE. Retries = 0 needs to be removed manually from DB, so if you see an abnormal increase in this table it is most likely because transmission is failing.


-- Contention on msgstore can be fixed with following techniques
-- Some extents needs to be added to this LOB segment.
alter table wcsadm.msgstore modify lob(message) (cache);

select sum(bytes/1024/1024/1024) from dba_segments where segment_name='SYS_LOB0000183219C00003$$'


alter table wcsadm.msgstore modify lob(message)(allocate extent (size 64M instance 1));
alter table wcsadm.msgstore modify lob(message)(allocate extent (size 64M instance 2));
alter table wcsadm.msgstore modify lob(message)(allocate extent (size 64M instance 3));
alter table wcsadm.msgstore modify lob(message)(allocate extent (size 64M instance 4));
alter table wcsadm.msgstore modify lob(message)(allocate extent (size 64M instance 5));
alter table wcsadm.msgstore modify lob(message)(allocate extent (size 64M instance 6));
alter table wcsadm.msgstore modify lob(message)(allocate extent (size 64M instance 1));
alter table wcsadm.msgstore modify lob(message)(allocate extent (size 64M instance 2));
alter table wcsadm.msgstore modify lob(message)(allocate extent (size 64M instance 3));
alter table wcsadm.msgstore modify lob(message)(allocate extent (size 64M instance 4));
alter table wcsadm.msgstore modify lob(message)(allocate extent (size 64M instance 5));
alter table wcsadm.msgstore modify lob(message)(allocate extent (size 64M instance 6));
alter table wcsadm.msgstore modify lob(message)(allocate extent (size 64M instance 1));
alter table wcsadm.msgstore modify lob(message)(allocate extent (size 64M instance 2));
alter table wcsadm.msgstore modify lob(message)(allocate extent (size 64M instance 3));
alter table wcsadm.msgstore modify lob(message)(allocate extent (size 64M instance 4));
alter table wcsadm.msgstore modify lob(message)(allocate extent (size 64M instance 5));
alter table wcsadm.msgstore modify lob(message)(allocate extent (size 64M instance 6));

select sum(bytes/1024/1024/1024) from dba_segments where segment_name='SYS_LOB0000183219C00003$$'

exec dbms_stats.gather_table_stats('WCSADM','MSGSTORE');

Reverse key index following

Table  Index
ADDRESS	ADDRESS_PK
CTXDATA	CTXDATA_PK
CTXDATA	I0000841
CTXMGMT	CTXMGMT_PK
CTXMGMT	I0000831
CTXMGMT	I0000895
CTXMGMT	I0000896
CTXMGMT	I0001299
EDPATMPAY	EDPATMPAY_IE1
EDPATMPAY	EDPATMPAY_IE2
EDPORDER	EDPORDER_IE2
EDPORDER	EDPORDER_PK
EDPORDER	I0000843
EDPPAYINST	I0000844
MBRREL	I0000328
MBRROLE	I0000275
MEMBER	I274130
MEMBER	SYS_C00147362
ORDADJDSC	SYS_C00147390
ORDADJUST	I0000171
ORDADJUST	SYS_C00147392
ORDERITEMS	I0000360
ORDERITEMS	I172138
ORDERITEMS	ORDERITEMS_PK
	
ORDERS	ORDERS_PK
ORDIADJUST	I0000177
ORDIADJUST	I0000178
ORDIADJUST	SYS_C00147405
ORDPROMOCD	I0000418
ORDPROMOCD	SYS_C00147420
PPCEXTDATA	I0000926
PPCEXTDATA	SYS_C00147468
PPCPAYMENT	I0000920
PX_CDUSAGE	SYS_C00147495
PX_COUPON	SYS_C00147496
PX_PROMOARG	SYS_C00147504
PX_USAGE	SYS_C00147511
SCHACTIVE	I1244114
SCHBRDCST	SYS_C00147563
TICKLER	I0000948
TICKLER	I0000978
USERS	I0001109
USERS	USERS_IF1
XORDERITEMS	XORDERITEMS_AK1
XORDERITEMS	XORDERITEMS_PK

