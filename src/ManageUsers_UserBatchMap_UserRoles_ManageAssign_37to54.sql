-- QUERY 37:
--Update user login information 1) update security question and answer 2) update login status

update tbl_lms_user_login
set user_security_q= 'which is your favortite dish', user_security_a ='Pizza',
user_login_status='INACTIVE'
where user_id='U01'

-- Verifying output:
select * from tbl_lms_user_login

-- QUERY 38:
--Get user user id, firstname, last name, login name, password and user firstname in ascending order.

select tbl_lms_user.user_id as uid,tbl_lms_user.user_first_name,tbl_lms_user.user_last_name,
tbl_lms_user_login.user_login_name,tbl_lms_user_login.user_password 
from tbl_lms_user,
tbl_lms_user_login
order by uid ASC

--QUERY 39:
-- Get total active users

select * from tbl_lms_user_login where user_login_status='ACTIVE'

--QUERY 40:
--Get all users for each role

select tbl_lms_user.user_first_name ||' '|| user_last_name username,tbl_lms_role.role_name from
((tbl_lms_user 
inner join tbl_lms_userrole_map on tbl_lms_user.user_id=tbl_lms_userrole_map.user_id) 
inner join tbl_lms_role on tbl_lms_userrole_map.role_id=tbl_lms_role.role_id)

--QUERY 41:
--Update password for particular inactive user 

update tbl_lms_user_login
set user_password='postgre123'
where user_id='U02'
--Verifying output:
select * from tbl_lms_user_login

--QUERY 42:
--Create a new user and assign the user to an existing batch
--Creating a new user
insert into tbl_lms_user values('U11','Jill','Rob',7012327867,'Tampa','EST','https://www.linkedin.com/in/JillRob','engineering','BE','H4');
select * from tbl_lms_user
--Assigning the user to an existing batch

insert into tbl_lms_userrole_map values(11,'U11','R03','Active');
select * from tbl_lms_userrole_map
insert into tbl_lms_userbatch_map values('UR11',11,3);
select * from tbl_lms_userrole_map

--QUERY 43:
--Update the user by assigning a new batch(you can create one for this purpose)

insert into tbl_lms_batch values(9,'Batch43','sdet','Active',2,5)
select * from tbl_lms_batch
update tbl_lms_userbatch_map
set batch_id=9
where ub_map_id='UR11'
select * from tbl_lms_userbatch_map

--QUERY 44:
--Get all users assigned to each batch
SELECT  user_id, user_first_name, user_last_name ,batch_id, batch_name,user_role_id
FROM tbl_lms_user 
INNER JOIN
tbl_lms_userrole_map 
using(user_id)
INNER JOIN tbl_lms_userbatch_map
using(user_role_id)
inner join tbl_lms_batch
using(batch_id)

--QUERY 45:
--Remove a user from a batch (All relevant tables should be affected)
Removed user U04
delete  from tbl_lms_user
        where user_id in
        (SELECT  user_id
FROM tbl_lms_user 
INNER JOIN
tbl_lms_userrole_map 
using(user_id)
INNER JOIN tbl_lms_userbatch_map
using(user_role_id)
inner join tbl_lms_batch
using(batch_id)
         where user_id='U04')

         
--User details of ‘U04’ deleted



--QUERY 46:
--Get all users who are assigned to batches of SDET program and give count by each batch

 select batch_name,user_id, user_first_name, user_last_name, program_name 
FROM tbl_lms_user 
INNER JOIN
tbl_lms_userrole_map 
using(user_id)
INNER JOIN tbl_lms_userbatch_map
using(user_role_id)
inner join tbl_lms_batch b
using(batch_id)
inner join tbl_lms_program p1 on p1.program_id=b.batch_program_id
where program_name = 'SDET'  

select batch_name,count(user_first_name)usercount  
FROM tbl_lms_user 
INNER JOIN
tbl_lms_userrole_map 
using(user_id)
INNER JOIN tbl_lms_userbatch_map
using(user_role_id)
inner join tbl_lms_batch b
using(batch_id)
inner join tbl_lms_program p1 on p1.program_id=b.batch_program_id
where program_name = 'SDET' group by batch_name

--QUERY 47:
--Get all users of a batch who's role is a student
--Inserting a new role “Student”
insert into tbl_lms_role('R04','Student','LMS Student')
--Adding users
insert into tbl_lms_user values('U12','Jill','Rob',7012327867,'Tampa','EST','https://www.linkedin.com/in/JillRob','engineering','BE','H4');
insert into tbl_lms_user values('U13','Adam','Rob',70123787867,'New York','EST','https://www.linkedin.com/in/AdamRob','engineering','MS','H4');
--Assignment of role as students to above two users
insert into tbl_lms_userrole_map values(12,'U12','R04','Active')
insert into tbl_lms_userrole_map values(13,'U13','R04','Active')

--verifying output
select * from tbl_lms_userrole_map

--QUERY 48:
--Get roles by name

select tbl_lms_user.user_first_name, tbl_lms_user.user_last_name,tbl_lms_role.role_id, tbl_lms_role.role_name from
((tbl_lms_user 
inner join tbl_lms_userrole_map on tbl_lms_user.user_id=tbl_lms_userrole_map.user_id) 
inner join tbl_lms_role on tbl_lms_userrole_map.role_id=tbl_lms_role.role_id) where user_first_name= 'John'

--QUERY 49:
--Get all users for each role

select tbl_lms_user.user_first_name ||' '|| user_last_name username,tbl_lms_role.role_name from
((tbl_lms_user 
inner join tbl_lms_userrole_map on tbl_lms_user.user_id=tbl_lms_userrole_map.user_id) 
inner join tbl_lms_role on tbl_lms_userrole_map.role_id=tbl_lms_role.role_id)


---QUERY 50:
--For a particular user mark his status as Inactive and mark the role also as inactive

update tbl_lms_userrole_map
set user_role_status='Inactive'
where user_id='U01'

--Verifying the output:

select * from tbl_lms_userrole_map

--QUERY 51:
--Create a new role and assign that role to an existing user or create new user
insert into tbl_lms_role values('R04','Trainer','LMS_Training')

update tbl_lms_userrole_map
set role_id='R04'
where user_id='U06'

--verifying updated row
select * from tbl_lms_userrole_map

--QUERY 52:
--Delete an existing role (all relevant tables should be affected)

delete from tbl_lms_role where role_id='R04'
One row deleted
 
--Verifying the output:
select * from tbl_lms_role
--RO4 row is deleted 

--QUERY 53:
--Create a new Assignment and assign it to an existing batch
--Assigning new assignment for "Batch_id=1"

insert into tbl_lms_assignments values (3,'Java Assignment', 'Java Pratice', 'Refer Books', '2022-04-15', 'File 1', 'File 2', 'File 3', 'File4', 'File5', 'U11', 1, 'U11')
--Verifying the output:
select * from tbl_lms_assignments

--QUERY 54:
--Get total number of assignments for every batch

select count(a_id), batch_id, batch_name
from tbl_lms_batch
inner join tbl_lms_assignments
on tbl_lms_assignments.a_batch_id=tbl_lms_batch.batch_id
group by batch_id













