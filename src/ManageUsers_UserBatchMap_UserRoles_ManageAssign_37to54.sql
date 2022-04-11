-- QUERY 37:
Update user login information
1) update security question and answer
2) update login status

update tbl_lms_user_login
set user_security_q= 'which is your favortite dish', user_security_a ='Pizza',
user_login_status='INACTIVE'
where user_id='U01'

-- Verifying output:
select * from tbl_lms_user_login

-- QUERY 38:
Get user user id, firstname, last name, login name, password and user firstname in ascending order.

select tbl_lms_user.user_id as uid,tbl_lms_user.user_first_name,tbl_lms_user.user_last_name,
tbl_lms_user_login.user_login_name,tbl_lms_user_login.user_password 
from tbl_lms_user,
tbl_lms_user_login
order by uid ASC

