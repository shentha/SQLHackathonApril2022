-- 37 - Update user login information 1) update security question and answer 2) update login status

update tbl_lms_user_login
set user_security_q= 'which is your favortite dish', user_security_a ='Pizza',
user_login_status='INACTIVE'
where user_id='U01'
