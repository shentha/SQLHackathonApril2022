/* 9. Get the program with maximum number of users */
WITH rslt1 AS 
  ( SELECT  pgm.program_name pgmname, COUNT(pgm.program_name) usrcount 
    FROM tbl_lms_program pgm 
    JOIN tbl_lms_batch batch ON pgm.program_id = batch.batch_program_id 
    JOIN tbl_lms_userbatch_map ubm  ON batch.batch_id = ubm.batch_id 
	GROUP BY pgm.program_name 
  ) 
	
SELECT rslt1.pgmname, rslt1.usrcount FROM rslt1 
WHERE rslt1.usrcount = ( SELECT MAX ( rslt1.usrcount) FROM rslt1 )
	
	
/* 10. Get all batches for particular program */
SELECT batch.batch_id , batch.batch_name, batch.batch_description, batch.batch_no_of_classes
FROM tbl_lms_batch batch
WHERE batch.batch_program_id = ( SELECT pgm.program_id 
                                 FROM tbl_lms_program pgm
                                 WHERE pgm.program_name LIKE 'SDET' ) 
/* Or */								 
CREATE VIEW batches_program_view AS
    SELECT batch.batch_id , batch.batch_name, batch.batch_description, batch.batch_no_of_classes
FROM tbl_lms_batch batch
WHERE batch.batch_program_id = ( SELECT pgm.program_id 
                                 FROM tbl_lms_program pgm
                                 WHERE pgm.program_name LIKE 'SDET' ) 

 SELECT * FROM batches_program_view		
 
 /* 32 - Create new User Profile */
	SELECT usr.user_time_zone time_zone , 
	       COUNT( usr.user_time_zone)
    FROM tbl_lms_user usr
    WHERE ( LOWER(usr.user_first_name) LIKE LOWER('suh%') 
          OR LOWER(usr.user_last_name) LIKE LOWER('Louis%') )
	      OR user_location LIKE 'Atlanta'
	      OR user_time_zone LIKE 'IST' 
    GROUP BY usr.user_time_zone
						  
						 
/* 33 - Create new User Profile */

INSERT INTO public.tbl_lms_user(
	user_id, user_first_name, user_last_name, user_phone_number, user_location, user_time_zone, user_linkedin_url, user_edu_ug, user_edu_pg, user_comments, user_visa_status)
	VALUES ('U15', 'Shyla', 'Aithala', 1003456567, 'Atlanta', 'EST', 'linkedin.com/1234', 'CompScience', 'Networking', null, 'H4-EAD') ;
	
						   
/* 34. Update user profile 1) update location 2) update timezone 3) update visa status */						 
UPDATE tbl_lms_user usr
	SET user_location='Atlanta', user_time_zone='EST', user_visa_status='US-Citizen' , last_mod_time=now()
	WHERE usr.user_id = 'U04' ;
	
/* 35 - Get user login name and status for a single user */
SELECT 
    login.user_login_name, login.user_login_status 
FROM tbl_lms_user_login login 
WHERE login.user_id = ( SELECT usr.user_id 
                           FROM tbl_lms_user usr
                           WHERE usr.user_first_name LIKE 'Robert%' 
                           OR usr.user_last_name LIKE 'Louis%' )  
	
/* 36.Get user security question and answer for a single user */
SELECT login.user_security_q, login.user_security_a 
FROM tbl_lms_user_login login 
WHERE user_login_name = 'Sarah.Anderson@gmail.com'

