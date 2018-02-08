/* Chapter 14: Example Database */
/* This script was created to be used with DB Browser for SQLITE */

/* Creates Database */
CREATE TABLE Courses (
    CourseID int NOT NULL,
    CourseName varchar(255) NOT NULL,
    TeacherID int NOT NULL,
    PRIMARY KEY(CourseID),
    FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID)
);

CREATE TABLE Teachers (
    TeacherID int NOT NULL,
    TeacherName varchar(255) NOT NULL,
    PRIMARY KEY(TeacherID)
);

CREATE TABLE Students (
    StudentID int NOT NULL,
    StudentName varchar(255) NOT NULL,
    PRIMARY KEY(StudentID)
);

CREATE TABLE StudentCourses (
    CourseID int NOT NULL,
    StudentID int NOT NULL,
    PRIMARY KEY(CourseID, StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

/* Inserts students */
INSERT INTO `Students`(`StudentID`,`StudentName`) VALUES (1,'Daniel');
INSERT INTO `Students`(`StudentID`,`StudentName`) VALUES (2,'Ricardo');
INSERT INTO `Students`(`StudentID`,`StudentName`) VALUES (3,'Pamela');
INSERT INTO `Students`(`StudentID`,`StudentName`) VALUES (4,'John');
INSERT INTO `Students`(`StudentID`,`StudentName`) VALUES (5,'Louis');
/* Inserts teachers */
INSERT INTO `Teachers`(`TeacherID`,`TeacherName`) VALUES (1,'Pedro');
INSERT INTO `Teachers`(`TeacherID`,`TeacherName`) VALUES (2,'Hector');
INSERT INTO `Teachers`(`TeacherID`,`TeacherName`) VALUES (3,'Rocio');
/* Inserts courses */
INSERT INTO `Courses`(`CourseID`,`CourseName`,`TeacherID`) VALUES (1,'Math',1);
INSERT INTO `Courses`(`CourseID`,`CourseName`,`TeacherID`) VALUES (2,'Spanish',3);
INSERT INTO `Courses`(`CourseID`,`CourseName`,`TeacherID`) VALUES (3,'English',3);
/* Inserts courses for students */
INSERT INTO `StudentCourses`(`CourseID`,`StudentID`) VALUES (1,1);
INSERT INTO `StudentCourses`(`CourseID`,`StudentID`) VALUES (1,2);
INSERT INTO `StudentCourses`(`CourseID`,`StudentID`) VALUES (1,3);
INSERT INTO `StudentCourses`(`CourseID`,`StudentID`) VALUES (1,4);
INSERT INTO `StudentCourses`(`CourseID`,`StudentID`) VALUES (2,1);
INSERT INTO `StudentCourses`(`CourseID`,`StudentID`) VALUES (2,2);
INSERT INTO `StudentCourses`(`CourseID`,`StudentID`) VALUES (3,1);

/* Exercise 1 */
/* Get a list of all the students and how many courses every student is enrolled in 8? */
SELECT Students.StudentID, MAX(Students.StudentName) as StudentName, COUNT(StudentCourses.CourseID) as Count
FROM Students LEFT JOIN StudentCourses ON Students.StudentID = StudentCourses.StudentID 
GROUP BY Students.StudentID;

/* Exercise 2 */
/* Get a list of all teachers and how many students they each teach */
/* A student enrolled in two courses of the same teacher will count twice */
/* Sort the list in descending order of number of students */
SELECT Teachers.TeacherID, Teachers.TeacherName, count(StudentCourses.StudentID) as Students FROM Teachers LEFT JOIN Courses
ON Teachers.TeacherID = Courses.TeacherID
LEFT JOIN StudentCourses
ON Courses.CourseID = StudentCourses.CourseID
GROUP BY Teachers.TeacherID
ORDER BY Students DESC;