//-- 19 - Delete batch
delete from public.tbl_lms_batch
where batch_id = 10

//--20 - 	Get no of classes for a batch	
select batch_id, batch_name, batch_description, batch_no_of_classes 
from public.tbl_lms_batch


//--21 - 	Get no of assignments by batch group by maximum assignments
select bth.batch_id, count(asg.a_id)
from public.tbl_lms_batch bth
  inner join public.tbl_lms_assignments asg
  on bth.batch_id = asg.a_batch_id
group by bth.batch_id
order by count(asg.a_id) desc


//-- 22 - 	Get batch with maximum number of users
select batch_id  
from public.tbl_lms_userbatch_map
group by batch_id
order by count(batch_id) desc 
LIMIT 1


//-- 23 - 	Create new user with role
INSERT INTO public.tbl_lms_user
VALUES 
('U11',
'Jeff',
'Didier',
2242459999,
'Chicago',
'CST',
'https://www.Linkedin.com/in/Jeff Didier/',
'Project Management',
'MBA', 
 ' ',
 'US-Citizen'
 )
   

INSERT INTO public.tbl_lms_userrole_map
VALUES (11,'U11','R03','Active')


//-- 24 - 	Get active users and inactive users	
select * from public.tbl_lms_userrole_map
where user_role_status = 'Active'

select * from public.tbl_lms_userrole_map
where user_role_status = 'InActive'"


//-- 25	- Get total users by role	
select ROLE_ID, count(user_id)
from public.tbl_lms_userrole_map
group by ROLE_ID


//-- 26	 - 1) Get users by name
          2) Get users by Program - medium"	




//-- 27 - Get users by batch and find which batch has highest and lowest no of users
select ubmap.batch_id, user_first_name, user_last_name
from public.tbl_lms_user luser
  Inner Join public.tbl_lms_userrole_map umap
        ON luser.user_id = umap.user_id
  Inner Join public.tbl_lms_userbatch_map ubmap
        ON umap.user_role_id = ubmap.user_role_id


//Batch with Lowest Number of User
select A.batch_id,count(A.batch_id) 
from 
        (select ubmap.batch_id, user_first_name, user_last_name
        from public.tbl_lms_user luser
        Inner Join public.tbl_lms_userrole_map umap
                ON luser.user_id = umap.user_id
        Inner Join public.tbl_lms_userbatch_map ubmap
                ON umap.user_role_id = ubmap.user_role_id)A
group by A.batch_id
order by count(A.batch_id) ASC
LIMIT 1


//Batch wtih Highest Number of Users
select A.batch_id,count(A.batch_id) 
from 
	(select ubmap.batch_id, user_first_name, user_last_name
	from public.tbl_lms_user luser
	Inner Join public.tbl_lms_userrole_map umap
		ON luser.user_id = umap.user_id
	Inner Join public.tbl_lms_userbatch_map ubmap
		ON umap.user_role_id = ubmap.user_role_id)A
group by A.batch_id
order by count(A.batch_id) DESC
LIMIT 1

//-- 28	- Get users by all the visa status
select user_visa_status, user_first_name, user_last_name
from public.tbl_lms_user

// -- 29 - Update status of user active and inactive
update public.tbl_lms_userrole_map
set user_role_status = 'Inactive'
where user_role_id = 1


update public.tbl_lms_userrole_map
set user_role_status = 'Active'
where user_role_id = 1


// -- 30 - Update user information all fields
update public.tbl_lms_user
set
user_first_name =  'Jeff',
user_last_name = 'Didier',
user_phone_number = 2242459999,
user_location = 'Chicago',
user_time_zone = 'CST',
user_linkedin_url = 'https://www.Linkedin.com/in/Jeff Didier/',
user_edu_ug ='Project Management',
user_edu_pg = 'MBA',
user_comments = 'Testing',
user_visa_status = 'US-Citizen'
where user_id = 'U11'


// -- 31 - Get users by each skill and give a count of users by every skill and find which skill has more number of users

//Query for User list according to SKILLS
select  SMAS.skill_name,  USR.user_first_name, USR.user_last_name
from public.tbl_lms_userskill_map USMAP
        Inner Join  public.tbl_lms_skill_master SMAS
        ON USMAP.skill_id = SMAS.skill_id
        
        Inner Join public.tbl_lms_user USR
        ON USR.User_id = USMAP.user_id
Order by Skill_name asc



//Query for Count of User Per Skills
select A.skill_name, count(A.skill_name)
from (
	select  SMAS.skill_name,  USR.user_first_name, USR.user_last_name
	from public.tbl_lms_userskill_map USMAP
		Inner Join  public.tbl_lms_skill_master SMAS
		ON USMAP.skill_id = SMAS.skill_id

		Inner Join public.tbl_lms_user USR
		ON USR.User_id = USMAP.user_id
	Order by Skill_name asc
	)A
group by A.skill_name


//Query for Skill with Most users
select A.skill_name, count(A.skill_name)
from (
	select  SMAS.skill_name,  USR.user_first_name, USR.user_last_name
	from public.tbl_lms_userskill_map USMAP
		Inner Join  public.tbl_lms_skill_master SMAS
		ON USMAP.skill_id = SMAS.skill_id

		Inner Join public.tbl_lms_user USR
		ON USR.User_id = USMAP.user_id
	Order by Skill_name asc
	)A
group by A.skill_name
Order by count(A.skill_name) desc
LIMIT 1
