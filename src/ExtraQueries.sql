--LIst of extra queries
--Filter number of classes in the batch using SQL CASE

SELECT batch_id,batch_name,batch_no_of_classes,
CASE
    WHEN batch_no_of_classes > 5 THEN 'Classes more than 5'
    WHEN batch_no_of_classes = 5 THEN 'Classes equal to 5'
    ELSE 'Classes less than 5'
END AS classes
FROM tbl_lms_batch

--Create a view to displaying all users from PST time zone

CREATE VIEW alluser_pst AS
SELECT user_id,user_first_name,user_last_name,user_time_zone
FROM tbl_lms_user
WHERE user_time_zone='PST';

select * from alluser_pst


--Get all students for all teachers for all batches

WITH Students AS 
	(SELECT 
		b.batch_id AS batch_id,
		b.batch_description AS batch_description,
		r.role_name AS role_name,
		r.role_id as role_id,
	 	u.user_id,
		u.user_first_name,
		u.user_last_name
	FROM tbl_lms_user AS u
		INNER JOIN tbl_lms_userrole_map AS um ON um.user_id = u.user_id
		INNER JOIN tbl_lms_role AS r ON r.role_id = um.role_id
		INNER JOIN tbl_lms_userbatch_map AS ub ON um.user_role_id = ub.user_role_id
		INNER JOIN tbl_lms_batch AS b ON b.batch_id = ub.batch_id
	WHERE r.role_id = 'R03'
	GROUP BY b.batch_id, u.user_id,r.role_id)
SELECT 
	b.batch_id AS batch_id,
	b.batch_description AS batch_description,
	r.role_name AS role_name,
	r.role_id as role_id,
	u.user_id AS Staff_user_id,
	u.user_first_name AS Staff_user_first_name,
	u.user_last_name AS Staff_user_last_name,
	students.user_id AS Student_user_id,
	students.user_first_name AS Student_first_name,
	students.user_last_name AS Student_last_name
FROM tbl_lms_user AS u
	INNER JOIN tbl_lms_userrole_map AS um ON um.user_id = u.user_id
	INNER JOIN tbl_lms_role AS r ON r.role_id = um.role_id
	INNER JOIN tbl_lms_userbatch_map AS ub ON um.user_role_id = ub.user_role_id
	INNER JOIN tbl_lms_batch AS b ON b.batch_id = ub.batch_id
	LEFT JOIN Students AS students ON students.batch_id = b.batch_id 
WHERE r.role_id = 'R02'
ORDER BY b.batch_id, u.user_id,r.role_id