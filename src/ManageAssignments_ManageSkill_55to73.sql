-- 56 - Find the staff who graded the assignments for a single batch. [additionally pulling no. of assignments to grade and graded by a user]
SELECT 
	b.batch_id AS batch_id,
	b.batch_description AS batch_description,
	 -- a.a_name AS assginment_name,
	u.user_id AS grader_user_id,
	u.user_first_name AS grader_user_first_name,
	u.user_last_name AS grader_user_last_name,
	COUNT(a.a_id) AS assignments_to_grade,
	COUNT(s.sub_id) AS assignments_graded
FROM tbl_lms_user AS u
	INNER JOIN tbl_lms_assignments AS a ON a.a_grader_id = u.user_id
	INNER JOIN tbl_lms_batch AS b ON a.a_batch_id = b.batch_id
	LEFT JOIN tbl_lms_submissions AS s ON s.sub_a_id = a.a_id and s.graded_by = a.a_grader_id
WHERE B.BATCH_ID = 2
GROUP BY b.batch_id, u.user_id



select * from tbl_lms_program;
select * from tbl_lms_batch;

select a.program_id,count(b.batch_id) AS BATCHCOUNT
from 
tbl_lms_program a 
INNER Join tbl_lms_batch b ON b.batch_program_id = a.program_id
group by a.program_id



select batch_program_id,count(batch_program_id) AS TOTALBATCH from tbl_lms_batch group by batch_program_id;
