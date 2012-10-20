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
