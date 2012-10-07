--Get orders in Pending (P) or Created (M) state for a user based on logonid
select orders_id from orders where status in ('P','M') and member_id in 
(select users_id from userreg where logonid='test_user2');
