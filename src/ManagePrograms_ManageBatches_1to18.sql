QUERY 2:
 Get the list of programs

select * from tbl_lms_program;


QUERY 3:
Get the list of programs by id  and name

select program_id, program_name from tbl_lms_program;



QUERY 4:

Get list of programs with program_name starts with S


select * from tbl_lms_program where program_name LIKE 'S%';






QUERY 5:
Update program by program name

update tbl_lms_program set program_name='updatepsql' where program_id='7865';



Now check the program name is updated  or not

select * from tbl_lms_program;




QUERY 6:
Update program by status


update tbl_lms_program set program_status='Inactive';




select * from tbl_lms_program;





QUERY 7:
Delete program whose id is given. 
Before deleting first create a new program for the test

insert into tbl_lms_program (program_id, program_name, program_description, program_status) values (20, 'delete', 'test_del', 'active');



Checking is it added or not
select * from tbl_lms_program;



 Now Delete the program whose id is given. 


delete from tbl_lms_program where program_id=20;


check that program is deleted or not

select * from tbl_lms_program;




QUERY 8:

Get the program with a maximum number of batches

select a.program_id,a.program_name,count(b.batch_id)
from tbl_lms_program a
inner join tbl_lms_batch b ON b.batch_program_id=a.program_id
group by a.program_id
having count(b.batch_id)=(select max(batchcount) from
(select a.program_id,count(b.batch_id) as batchcount
from tbl_lms_program a
join tbl_lms_batch b on
b.batch_program_id= a.program_id
group by a.program_id)as batchcount);






QUERY 11:
Create batch
INSERT INTO tbl_lms_batch(batch_id,batch_name,batch_description,batch_status,batch_program_id,batch_no_of_classes) VALUES (9,4,'SDET BATCH47','Active',2,7);



Checking is it added or not
select * from tbl_lms_batch;



QUERY 12:


Get list of batches

select * from tbl_lms_batch;




QUERY 13:

Get batches by program

select batch_program_id from tbl_lms_batch;




QUERY 14:
Get batch by id

select batch_id from tbl_lms_batch;


QUERY 15:

Get batch by name

select * from tbl_lms_batch where batch_name='05';

QUERY 16:

Update batch by name

update tbl_lms_batch set batch_name= '07' where batch_id =10 ;




Check its updated or not
select * from tbl_lms_batch;


QUERY 17:
update batch description

update tbl_lms_batch set batch_description = 'sdet';



Check its updated or not
select * from tbl_lms_batch;



QUERY 18:

Update batch status

update tbl_lms_batch set batch_status = 'inactive';





Check its updated or not
select * from tbl_lms_batch;
		

