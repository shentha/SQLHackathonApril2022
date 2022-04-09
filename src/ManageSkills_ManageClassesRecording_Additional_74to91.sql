-- 74 - Get user firstname, last name, skills, months of experience
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