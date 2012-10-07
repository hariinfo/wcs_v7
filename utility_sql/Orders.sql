--Get orders in Pending (P) or Created (M) state for a user based on logonid
select * from orders where status in ('P','M') and member_id in 
(select users_id from userreg where logonid='test_user2')
order by LASTUPDATE desc;

-- Get Payment number of payment types associated to the order, if more than
one payment is associated we should see more than one PPCPAYINST_ID associated to
and ORDER

select * from PPCPAYINST where order_id in 
(select orders_id from orders where status in ('P','M') and member_id in 
(select users_id from userreg where logonid='test_user2')
);


-- Get Payment type details associated to the order, if more than
one payment is associated we should see more than one PPCPAYINST_ID associated to
and ORDER, DATAVALUE in ppcextdata is usually in encrypted format
select * from ppcextdata where PPCPAYINST_ID in
(select PPCPAYINST_ID from PPCPAYINST where order_id in 
(select orders_id from orders where status in ('P','M') and member_id in 
(select users_id from userreg where logonid='test_user2')
));



