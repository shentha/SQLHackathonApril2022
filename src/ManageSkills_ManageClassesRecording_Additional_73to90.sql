-- 73 - Get user firstname, last name, skills, months of experience
SELECT user_first_name,user_last_name from tbl_lms_user;
Query:
SELECT 
	tbl_lms_user.user_first_name,
	tbl_lms_user.user_last_name,
	tbl_lms_skill_master.skill_name,
	tbl_lms_userskill_map.months_of_exp
FROM 
	tbl_lms_user	
INNER JOIN
	tbl_lms_userskill_map ON tbl_lms_user.user_id = tbl_lms_userskill_map.user_id
INNER JOIN 
	tbl_lms_skill_master ON tbl_lms_userskill_map.skill_id = tbl_lms_skill_master.skill_id;
	
	
	/*Count number of users based on skill*/
SELECT tbl_lms_skill_master.skill_name,count(tbl_lms_user.user_id) AS NoOfUsers from tbl_lms_user
INNER JOIN 
	tbl_lms_userskill_map ON tbl_lms_user.user_id = tbl_lms_userskill_map.user_id
INNER JOIN
	tbl_lms_skill_master ON tbl_lms_userskill_map.skill_id = tbl_lms_skill_master.skill_id
	group by tbl_lms_skill_master.skill_name;

--74- Count number of users based on skill
SELECT tbl_lms_skill_master.skill_name,count(tbl_lms_user.user_id) AS NoOfUsers
 from tbl_lms_user
INNER JOIN 
	tbl_lms_userskill_map ON tbl_lms_user.user_id = tbl_lms_userskill_map.user_id
INNER JOIN
	tbl_lms_skill_master ON tbl_lms_userskill_map.skill_id = tbl_lms_skill_master.skill_id
	group by tbl_lms_skill_master.skill_name;
	
	
	
--75- Create a Class Schedule
	
INSERT INTO tbl_lms_class_sch(
    class_no,batch_id,class_topic,class_description,class_comments,class_notes,
class_recording_path)
    VALUES (002,2, 'Boot Strap','Sasmita Nayak class','take this seriously','
see you','C:\Users\sasmi\Downloads\Sas_Querires');



--76- Create 5 more Class Schedules
    
INSERT INTO tbl_lms_class_sch
(class_no,batch_id,class_topic,class_description,class_staff_id,class_comments,class_notes,class_recording_path)
    VALUES 
         (002,2, 'Boot Strap','Saasnaam class','U03','take this seriously','see you','C:\Users\saami\Downloads\my_Querires'),
         (002,1, 'JavaScript','Saasnaam class','U03','take this seriously','see you','C:\Users\saami\Downloads\my_Querires'),
         (003,3, 'ANgularJs','Saasnaam class','U03','take this seriously','see you','C:\Users\saami\Downloads\my_Querires'),
         (002,2, 'MicroServices','Saasnaam class','U03','take this seriously','see you','C:\Users\saami\Downloads\my_Querires'),
         (002,3, 'React JS','Saasnaam class','U03','take this seriously','see you','C:\Users\saami\Downloads\my_Querires');
        
-- using stored procedures
create procedure Insertmultiplerows(b_id int,c_no int,c_date date,c_topic varchar,c_staffid varchar,c_desc varchar,c_comments varchar,c_notes varchar,c_recording varchar)
        language sql
 as $$
     Insert into tbl_lms_class_sch (batch_id,class_no,class_date,class_topic,class_staff_id,class_description,class_comments,class_notes,class_recording_path) 
         values (b_id,c_no,c_date,c_topic,c_staffid,c_desc,c_comments,c_notes,c_recording);
         $$
         
         call Insertmultiplerows(2,3,'2022-04-12','Rest Assured','U05','Rest Assured class','excellent','C:\myRecords', 'C:\Recordings');
	 
	 
--77--Get Class Schedules for a single batch
SELECT COUNT(*) AS classSchedules,tbl_lms_batch.batch_description
FROM tbl_lms_class_sch 
JOIN tbl_lms_batch ON tbl_lms_class_sch.batch_id = tbl_lms_batch.batch_id
GROUP BY tbl_lms_batch.batch_description;

--78-"Update Class Schedules 1) Change date 2) Change staff"

 UPDATE tbl_lms_class_sch

SET class_date = '20222-04-10',class_staff_id='U05' WHERE cs_id = 12 ;


--79-Delete Class Schedules for an existing batch
delete from public.tbl_lms_class_sch where batch_id = 2;

--80- Get all class schedules for a Staff
SELECT *FROM public.tbl_lms_class_sch WHERE class_staff_id =  'U03' ;

--81- Create Attendance for a class schedule
ALTER TABLE public.tbl_lms_class_sch
  ADD Attendance VARCHAR(50);
  
  
  --82- Get Attendance by Students for a single class schedule
  SELECT tbl_lms_attendance.student_id,tbl_lms_class_sch.attendance
FROM tbl_lms_class_sch
JOIN tbl_lms_attendance ON tbl_lms_class_sch.cs_id = tbl_lms_attendance.cs_id;


--83- Get number of students who were present  for  each class by batch
SELECT * FROM tbl_lms_batch;
SELECT * FROM tbl_lms_attendance;
SELECT * FROM tbl_lms_class_sch;
UPDATE tbl_lms_class_sch
SET attendance = 'Present' WHERE class_staff_id ='U02'; 


--84- "Update Attendance 1) Mark Attendance as Present or Absent"
SELECT * FROM tbl_lms_batch;
SELECT * FROM tbl_lms_attendance;
SELECT * FROM tbl_lms_class_sch;
UPDATE tbl_lms_class_sch
SET attendance = 'Present' WHERE class_staff_id ='U02'; 

--85-Delete Attendance for a all Class Schedules of a particular batch
DELETE FROM tbl_lms_attendance WHERE cs_id IN
(SELECT tbl_lms_attendance.cs_id FROM tbl_lms_attendance
INNER JOIN tbl_lms_class_sch ON tbl_lms_attendance.cs_id = tbl_lms_class_sch.cs_id
WHERE tbl_lms_class_sch.batch_id=1);


--86-Get All Recordings for a existiing batch
SELECT tbl_lms_batch.batch_id,tbl_lms_batch.batch_description,
tbl_lms_class_sch.class_recording_path 
FROM tbl_lms_class_sch
INNER JOIN tbl_lms_batch 
ON tbl_lms_class_sch.batch_id = tbl_lms_batch.batch_id;

--87-Get Recordings for a particular class schedue
SELECT class_recording_path 
FROM tbl_lms_class_sch
WHERE cs_id = 3;

--88-Update Recordings 1) Remove existing recording and update with new one
CREATE OR REPLACE PROCEDURE update_recordings(recpath varchar, classid bigint)
LANGUAGE SQL
BEGIN ATOMIC
   UPDATE public.tbl_lms_class_sch
        SET    class_recording_path= recpath , last_mod_time=now()
        WHERE cs_id = classid ;
END; 

call update_recordings('C:\seleniumRecordings',5);  


--89- Create a table named tbl_lms_hackathon with columns - Hackathon_Id(primary key) , Hackathon_name : max 20 characters, Hackathon_description : paragraph, Start_date, End_date)
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




--90- Create a table named tbl_lms_userHackathon_map with columns (User_hackathon_id(primary key), user_id(references tbl_lms_user : user_id), hackathon_id(references tbl_lms_hackathon : hackathon_id)
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




      
    
    
    

	
