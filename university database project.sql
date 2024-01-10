DROP DATABASE IF EXISTS `university`;
CREATE DATABASE `university` DEFAULT CHARACTER SET=utf8;
USE university;


DROP TABLE IF EXISTS `student`;
DROP TABLE IF EXISTS `instructor`;
DROP TABLE IF EXISTS `department`;

CREATE TABLE `department` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `dept_name` VARCHAR(50) NOT NULL,
  `building` VARCHAR(50) NOT NULL,
  `budget` VARCHAR(50) NOT NULL DEFAULT 0,
  PRIMARY KEY(`id`),
  UNIQUE KEY `ix_dept_name` (`dept_name`)
) ENGINE=InnoDB;

CREATE TABLE `instructor` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `inst_name` VARCHAR(30) NOT NULL,
  `salary` int(13) UNSIGNED NOT NULL,
  `inst_dept` VARCHAR(50) NOT NULL,
  FOREIGN KEY (`inst_dept`) REFERENCES `department` (`dept_name`)
  ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE `student` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `advisor_id` INT(10) UNSIGNED DEFAULT NULL,
  `stud_name` VARCHAR(30) NOT NULL,
  `tot_cred` INT(3) UNSIGNED NOT NULL,
  `stud_dept` VARCHAR(50) NOT NULL,
  FOREIGN KEY (`advisor_id`) REFERENCES `instructor` (`id`)
  ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (`stud_dept`) REFERENCES `department` (`dept_name`)
  ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;
 
CREATE TABLE `course` (
  `course_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `title` VARCHAR(50) NOT NULL,
  `credits` INT(3) UNSIGNED NOT NULL DEFAULT 0,
  `course_dept` VARCHAR(50) NOT NULL,
  FOREIGN KEY (`course_dept`) REFERENCES `department` (`dept_name`)
  ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

INSERT INTO `department` (dept_name, building, budget) VALUES
  ("Computer Science", "Network", 1600000),
  ("Economics", "Efficient", 1200000),
  ("Art", "Pretty", 600000),
  ("Business", "Big", 3200000),
  ("Music", "Sound", 120000),
  ("Math", "Theory", 40000),
  ("Statistics", "Probably", 70000);

INSERT INTO `instructor` (inst_name, salary, inst_dept) VALUES
  ("A retired Professor", 65000, "Computer Science"),
  ("Alan Smith", 40000, "Computer Science"),
  ("Cristiano Roony", 38000, "Economics"),
  ("John Marry", 34000, "Economics"),
  ("Marron5", 60000, "Music"),
  ("Peter Drucker", 120000, "Business");

INSERT INTO `student` (advisor_id, stud_name, tot_cred, stud_dept) VALUES
  (1, "Appler", 14, "Computer Science"),
  (2, "Microsofter", 18, "Computer Science"),
  (2, "Googler", 20, "Computer Science"),
  (6, "Mac Marshall", 15, "Economics"),
  (NULL, "Eminem", 17, "Music");

INSERT INTO `course` (title, credits, course_dept) VALUES
  ("Linear Regression", 3, "Math"),
  ("Inferential Statistics", 3, "Statistics"),
  ("Descriptive Statistics", 3, "Statistics"),
  ("Machine Learning", 4, "Computer Science");

select * from department;
select * from instructor;
select * from student;
select * from course;

/*find the information in department where department name is economics. */
select * from department
where dept_name = 'Economics';

/*find the information of instructors which has salary more than 35000 and department of instructor is economics. */
select * from instructor
where inst_dept = 'Economics' and salary > 35000;

/*find all details of student which name is eminem. */
select * from student 
where stud_name = 'eminem';
 
/*find course id from course table where course id is CSE%.*/ 
select course_id from course
where course_id like 'CSE%';

/*find maximum salary of instructor.*/
select max(salary) from instructor;

/*For each department find the name of instructor and max salary in that department.*/
select inst_name,max(salary) from instructor
group by inst_name;

/*for each student find the name and count the id from student table having the total credit greater than equal to 17*/
select stud_name,count(id) from student
group by stud_name 
having 'tot_cred' <= 17;

/*Increase (upadate) salary of each instructor in computer science department by 10% if there salary is between 0 to 70000*/
update instructor set salary=salary*1.1
where inst_dept = 'computer science' and salary between 0 and 70000;

select * from instructor;

/*delete instructor of music department*/
delete from student
where stud_dept = 'music';

select * from student;

/*Showing all student alongside their course, if they exist*/
select *
from course
left join student
on course_id=id;

/*students and course with RIGHT JOIN*/
select *
from course
right join student
on course_id=id;

/*Showing all student and all course*/
select *
from course
left join student
on course_id=id
union
select *
from course
right join student
on course_id=id;

/*returns the all (duplicate values also) from both the "student" and the "course" table:*/
select *
from course
left join student
on course_id=id
union all
select *
from course
right join student
on course_id=id;




