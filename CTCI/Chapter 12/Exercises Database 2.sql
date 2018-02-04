/* Chapter 14: Exercises Database 2*/
/* This script was created to be used with DB Browser for SQLITE */

/* Creates Database */

CREATE TABLE Students (
    StudentID int NOT NULL,
    StudentName varchar(150) NOT NULL,
    Address varchar(500) NOT NULL,
    PRIMARY KEY(StudentID)
);

CREATE TABLE Courses (
    CourseID int NOT NULL,
    CourseName varchar(150) NOT NULL,
    PRIMARY KEY(CourseID)
);

CREATE TABLE CourseEnrollment (
    CourseID int NOT NULL,
    StudentID int NOT NULL,
    Grade numeric NOT NULL,
    Term int NOT NULL,
    PRIMARY KEY(CourseID, StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

/* Inserts students */
INSERT INTO `Students`(`StudentID`,`StudentName`,`Address`) VALUES (1,'Daniel','Monty Python St 123');
INSERT INTO `Students`(`StudentID`,`StudentName`,`Address`) VALUES (2,'Pamela','Richard Stallman Blvd 500');
INSERT INTO `Students`(`StudentID`,`StudentName`,`Address`) VALUES (3,'Louis','Lincoln Av 700');
INSERT INTO `Students`(`StudentID`,`StudentName`,`Address`) VALUES (4,'John','Market Av 394');

/* Inserts courses */
INSERT INTO `Courses`(`CourseID`,`CourseName`) VALUES (1,'Math');
INSERT INTO `Courses`(`CourseID`,`CourseName`) VALUES (2,'Spanish');
INSERT INTO `Courses`(`CourseID`,`CourseName`) VALUES (3,'English');

/* Inserts enrollments */
INSERT INTO `CourseEnrollment`(`CourseID`,`StudentID`,`Grade`,`Term`) VALUES (1,1,91.7,0);
INSERT INTO `CourseEnrollment`(`CourseID`,`StudentID`,`Grade`,`Term`) VALUES (1,2,90.0,0);
INSERT INTO `CourseEnrollment`(`CourseID`,`StudentID`,`Grade`,`Term`) VALUES (1,3,77.5,0);
INSERT INTO `CourseEnrollment`(`CourseID`,`StudentID`,`Grade`,`Term`) VALUES (1,4,50.9,0);
INSERT INTO `CourseEnrollment`(`CourseID`,`StudentID`,`Grade`,`Term`) VALUES (2,1,95.5,0);
INSERT INTO `CourseEnrollment`(`CourseID`,`StudentID`,`Grade`,`Term`) VALUES (2,2,84.9,0);
INSERT INTO `CourseEnrollment`(`CourseID`,`StudentID`,`Grade`,`Term`) VALUES (2,3,82.1,0);
INSERT INTO `CourseEnrollment`(`CourseID`,`StudentID`,`Grade`,`Term`) VALUES (2,4,61.6,0);
INSERT INTO `CourseEnrollment`(`CourseID`,`StudentID`,`Grade`,`Term`) VALUES (3,1,99.2,0);
INSERT INTO `CourseEnrollment`(`CourseID`,`StudentID`,`Grade`,`Term`) VALUES (3,2,88.7,0);
INSERT INTO `CourseEnrollment`(`CourseID`,`StudentID`,`Grade`,`Term`) VALUES (3,3,79.4,0);


