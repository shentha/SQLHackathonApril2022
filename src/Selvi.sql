/* 33 - Create new User Profile */

INSERT INTO public.tbl_lms_user(
	user_id, user_first_name, user_last_name, user_phone_number, user_location, user_time_zone, user_linkedin_url, user_edu_ug, user_edu_pg, user_comments, user_visa_status)
	VALUES ('U15', 'Shyla', 'Aithala', 1003456567, 'Atlanta', 'EST', 'linkedin.com/1234', 'CompScience', 'Networking', null, 'H4-EAD') ;
	

/* Get user login name and status for a single user */
SELECT 
    login.user_login_name, login.user_login_status 
FROM tbl_lms_user_login login 
WHERE login.user_id = ( SELECT usr.user_id 
                           FROM tbl_lms_user usr
                           WHERE usr.user_first_name LIKE 'Robert%' 
                           OR usr.user_last_name LIKE 'Louis%' )  