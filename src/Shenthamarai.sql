/* 9. Get the program with maximum number of users */
    SELECT  pgm.program_name pgmname, 
            COUNT(pgm.program_name) usrcount 
    FROM tbl_lms_program pgm 
    JOIN tbl_lms_batch batch ON pgm.program_id = batch.batch_program_id 
    JOIN tbl_lms_userbatch_map ubm  ON batch.batch_id = ubm.batch_id 
	JOIN tbl_lms_userrole_map urm ON ubm.user_role_id = urm.user_role_id
	JOIN tbl_lms_role rle ON urm.role_id = rle.role_id
	WHERE rle.role_name = 'Student' OR rle.role_name LIKE 'User'
	GROUP BY pgm.program_name 
	ORDER BY COUNT(pgm.program_name) DESC
	LIMIT 1
	
	
/* 10. Get all batches for particular program */
SELECT batch.batch_id , batch.batch_name, batch.batch_description, batch.batch_no_of_classes
FROM tbl_lms_batch batch
WHERE batch.batch_program_id = ( SELECT pgm.program_id 
                                 FROM tbl_lms_program pgm
                                 WHERE pgm.program_name LIKE 'SDET' ) 
ORDER BY batch.batch_id
/* Or */								 
CREATE VIEW batches_program_view AS
    SELECT batch.batch_id , batch.batch_name, batch.batch_description, batch.batch_no_of_classes
FROM tbl_lms_batch batch
WHERE batch.batch_program_id = ( SELECT pgm.program_id 
                                 FROM tbl_lms_program pgm
                                 WHERE pgm.program_name LIKE 'SDET' ) 

 SELECT * FROM batches_program_view		
 
 /* 32 - Get user info for users based on the following filters: 1) filter by first or last name 2) filter by location 3) filter by timezone. Also find out how many users are  there for each timezone" */ 
	SELECT usr.user_time_zone time_zone , 
	       COUNT( usr.user_time_zone)
    FROM tbl_lms_user usr
    WHERE ( LOWER(usr.user_first_name) LIKE LOWER('Robert%') 
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


/* 90 - Create a table named tbl_lms_hackathon */ 
CREATE TABLE public.tbl_lms_hackathon (
    hackathon_id integer NOT NULL PRIMARY KEY,
    hackathon_name varchar(20) NOT NULL,
    hackathon_description varchar,
    start_time timestamp without time zone DEFAULT now() NOT NULL,
    end_time timestamp without time zone DEFAULT now() NOT NULL
  );
commit;

/* sequence generation */
CREATE SEQUENCE public.tbl_lms_hackathon_hackathon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE public.tbl_lms_hackathon_hackathon_id_seq OWNER TO postgres;


/* 91 - Create a table named tbl_lms_user_hackathon_map */ 
	CREATE TABLE public.tbl_lms_user_hackathon_map (
       user_hackathon_id integer NOT NULL PRIMARY KEY,
       user_id character varying NOT NULL,
       hackathon_id integer NOT NULL,
       FOREIGN KEY (user_id) REFERENCES tbl_lms_user(user_id) ON DELETE CASCADE,
       FOREIGN KEY (hackathon_id) REFERENCES tbl_lms_hackathon(hackathon_id) ON DELETE CASCADE,
       UNIQUE (user_id, hackathon_id)
    );
    commit;
  
  /* sequence generation */
CREATE SEQUENCE public.tbl_lms_user_hackathon_map_user_hackathon_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE public.tbl_lms_user_hackathon_map_user_hackathon_id_seq OWNER TO postgres;

/* 80 : Get all class schedules for a Staff*/
SELECT cs_id, batch_id, class_no, class_date, class_topic, class_staff_id, class_description, class_comments, 
       class_notes, class_recording_path, creation_time, last_mod_time
	FROM public.tbl_lms_class_sch 
	WHERE class_staff_id =  'U03' 
	/* or */ 
SELECT cs_id, batch_id, class_no, class_date, class_topic, class_staff_id, class_description, class_comments, 
       class_notes, class_recording_path, creation_time, last_mod_time
	FROM public.tbl_lms_class_sch 
	WHERE class_staff_id = ( SELECT usr.user_id staffid 
    FROM tbl_lms_user usr
    WHERE ( LOWER(usr.user_first_name) LIKE LOWER('vijay%')) ) 
	
/* 88. "Update Recordings 1) Remove existing recording and update with new one" */	
CREATE OR REPLACE PROCEDURE update_recordings(recpath varchar, classid bigint)
LANGUAGE SQL
BEGIN ATOMIC
   UPDATE public.tbl_lms_class_sch
	SET    class_recording_path= recpath , last_mod_time=now()
	WHERE cs_id = classid ;
END; 

call update_recordings('C:\seleniumRecordings',5);  
