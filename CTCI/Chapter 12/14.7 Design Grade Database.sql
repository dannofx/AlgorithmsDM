/* 14.7 Design Grade Database */

/* Sqlite doesn't have an implementation for TOP X percent, so I will use LIMIT */
/* I will also assume that the problem is asking for the 2 first students with best grades and not for the 10 percent */
/* It doesn't have an implementation for @Declare, either. */
SELECT Students.StudentID, Students.StudentName, avg(CourseEnrollment.Grade) AS StudentGPA 
FROM Students INNER JOIN CourseEnrollment ON Students.StudentID = CourseEnrollment.StudentID
INNER JOIN	(
	        	SELECT min(GPA) AS MinGPA 
	        	FROM (
	        			SELECT avg(CourseEnrollment.Grade) AS GPA 
	        			FROM CourseEnrollment 
	        			GROUP BY CourseEnrollment.StudentID 
	        			ORDER BY GPA DESC LIMIT 2
	        		 ) AS BestTwoStudents
	       	) AS LowLimit
GROUP BY Students.StudentID 
HAVING StudentGPA >= LowLimit.MinGPA
ORDER BY StudentGPA DESC
