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