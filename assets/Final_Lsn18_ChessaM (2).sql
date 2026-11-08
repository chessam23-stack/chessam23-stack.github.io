# GOal:As a DBA, you should find the maximum salary of the employees and ensure that all 
#jobs meet the organization's profile standard. You also need to calculate bonuses to find extra costs for expenses. 
#This will improve the organization's overall performance by ensuring all the employees required receive training.

# ACTION 1
#First I am creating the database/schema
CREATE DATABASE employee;

#Next, I am making sure it is selected. It shows bold on the left window

USE employee;

#I imported the data science team table using the import wizard. I make sure all the data types were correct when importing
#and that it had the correct name. To check that it worked, I used SELECT * to see the table.

SELECT *
FROM data_science_team;

#I imported the employee record table using the import wizard. I make sure all the data types were correct when importing
#and that it had the correct name. To check that it worked, I used SELECT * to see the table.

SELECT *
FROM emp_record_table;

# For the Project Data Table I did the same process as above. 
#I found that it was not importing correctly because
# the start date and closure date were not in the correct orientation for mySQL.
#When I checked the table, the columns were named correctly but there were no values in the table. 
#I went to csv converter website to see if I could alter the dates to the correct format, and then
#input the script.
# The website was not able to convert the dates to the correct format for me,
#but I could copy the script and then I changed each date to YYYY-MM-DD 
# manually after I inserted the code from the converter website.
# another way I could have done it, was open it in Excel first as a CSV, then clean data type to 
#the correct format, then save it, and then use it in the csv converter.  OR if it isn't changing
#the format correctly, I could have changed them manually in excel, saving, and then trying to inport to mySQL

SELECT *
FROM proj_table;

DROP TABLE proj_table;

CREATE TABLE proj_table(
   PROJECT_ID   VARCHAR(4) NOT NULL PRIMARY KEY
  ,PROJ_NAME    VARCHAR(30) NOT NULL
  ,DOMAIN       VARCHAR(10) NOT NULL
  ,START_DATE   DATE  NOT NULL
  ,CLOSURE_DATE DATE  NOT NULL
  ,DEV_QTR      VARCHAR(2) NOT NULL
  ,STATUS       VARCHAR(7) NOT NULL
);
INSERT INTO proj_table(PROJECT_ID,PROJ_NAME,DOMAIN,START_DATE,CLOSURE_DATE,DEV_QTR,STATUS) VALUES ('P103','Drug Discovery','HEALTHCARE','2021-04-06','2021-06-20','Q1','DONE');
INSERT INTO proj_table(PROJECT_ID,PROJ_NAME,DOMAIN,START_DATE,CLOSURE_DATE,DEV_QTR,STATUS) VALUES ('P105','Fraud Detection','FINANCE','2021-04-11','2021-06-25','Q1','DONE');
INSERT INTO proj_table(PROJECT_ID,PROJ_NAME,DOMAIN,START_DATE,CLOSURE_DATE,DEV_QTR,STATUS) VALUES ('P109','Market Basket Analysis','RETAIL','2021-04-12','2021-06-30','Q1','DELAYED');
INSERT INTO proj_table(PROJECT_ID,PROJ_NAME,DOMAIN,START_DATE,CLOSURE_DATE,DEV_QTR,STATUS) VALUES ('P204','Supply Chain Management','AUTOMOTIVE','2021-07-15','2021-09-28','Q2','WIP');
INSERT INTO proj_table(PROJECT_ID,PROJ_NAME,DOMAIN,START_DATE,CLOSURE_DATE,DEV_QTR,STATUS) VALUES ('P302','Early Detection of Lung Cancer','HEALTHCARE','2021-10-08','2021-12-18','Q3','YTS');
INSERT INTO proj_table(PROJECT_ID,PROJ_NAME,DOMAIN,START_DATE,CLOSURE_DATE,DEV_QTR,STATUS) VALUES ('P406','Customer Sentiment Analysis','RETAIL','2021-07-09','2021-09-24','Q2','WIP');

#Here I checked to make sure the output looked correct
SELECT *
FROM proj_table;

# Action 2
# In my select statement, I specified the information in the action 2 instructions. 
#These will form the columns in my table. 
#My from statement lists the employee record table and denotes where the column data comes from.

SELECT EMP_ID , FIRST_NAME , LAST_NAME , GENDER , DEPT , EMP_RATING
FROM emp_record_table;

# Action 3

#employee rating Less than 2
# I used the previous query (from action 2--original) SELECT and FROM statements.
#Next I added a WHERE statement because I wanted to
# filter my result to  produce an output that only shows
#the rows that had an emp rating less than 2.

SELECT EMP_ID , FIRST_NAME , LAST_NAME , GENDER , DEPT , EMP_RATING
FROM emp_record_table
WHERE EMP_RATING < 2;

#employee greater than 4

# I used the original select and from statement
#In this case, my where statement uses the great than symbol > and 4
#This filters rows to only show up if the rating is above 4.

SELECT EMP_ID , FIRST_NAME , LAST_NAME , GENDER , DEPT , EMP_RATING
FROM emp_record_table
WHERE EMP_RATING > 4;

# employee rating between 2 and 4

# I used the original select and from statement
# to filter between 2 and 4, I used a where statement
# using between/and.  This will output just ratings
#between 2 and 4.
# I also added an order by statement so I could check my
# work and verify that the ratings are only 2, 3, or 4.

SELECT EMP_ID , FIRST_NAME , LAST_NAME , GENDER , DEPT , EMP_RATING
FROM emp_record_table
WHERE EMP_RATING BETWEEN 2 AND 4
ORDER BY EMP_RATING;

# Action 4- Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the 
#Finance department from the employee table and then give the resultant column alias as NAME.

#To begin, I put the select statement. I need first name and last name, and then I need to use
#the concat() string function to link the two column values together in each row to create a new table
#with both names together.
#To specify what this looks like, in the parenthese after CONCAT I added
 #column 1 name, a space in between ' ' , and then column 2 name
# Then I specified the name of the new column using an AS statement--or alias.
#My from statement calls from the employee record table.
#Then I filted by the finance department using a WHERE statement.
#The resulting table has three columns, and only shows employees that are in the finance dept.

SELECT FIRST_NAME , LAST_NAME , CONCAT( FIRST_NAME, ' ',LAST_NAME) AS NAME
FROM emp_record_table
WHERE DEPT = 'Finance';

#ACTION 5-Write a query to list only those employees who have someone reporting to them. 
#Also, show the number of reporters (including the President).


# First, I had to figure out what statements to use in my query. 
# First I tried using a subquery because we did
# a similar question together in class.  Then I decided which part of the problem
#needed to be in the inner and outer query.  I experimented
#trying out just the inner query in a bunch of ways.
# I settled on the inner query showing the count for each manager. This was
#helpful because it incorporated an aggregate function, which wouldn't work
#if I just had 1 query.
#I considered the inner query as its own little mini table--which helped me determine syntax.
	#The inner query calls up the manager ID and a count of the rows
    #that are have manager IDs.  My filtering where statement specifies
    #that I just want rows are not null-meaning they all have to
    #have a manager id input. Because this inner query has an aggregate, I needed to use
	# the group by clause to visualize the manager_id column in the output table. 
    # I put the inner query, in parentheses and then gave it the alias r for
    #the outter query's join.

#Then I had to complete the outter query by defining the join.
#This was tricky because the join was between the inner query and itself
#as opposed to a join of two tables. Thinking about the inner query as 
#its own little table, helped me think through the join. My inner join was linked by the
#outter query table e and the inner query r.

# I finished my outer query by decided to * the select statement, 
# The problem doesn't specify or limit the number of columns in the output.
#My outer query's from statement was the original employee table
# and gave it the alias e to define the columns for the join.

SELECT *
FROM emp_record_table e
INNER JOIN
	(SELECT MANAGER_ID, COUNT(*) AS Reporters
	FROM emp_record_table
    WHERE MANAGER_ID IS NOT NULL
    GROUP BY MANAGER_ID) r
 ON e.EMP_ID = r.MANAGER_ID;

 #I was also able to see in my output table that the rows called all had roles defined as manager
 #except for the President because he is his own manager and technically everyone's boss.

# Action 6 Write a query to list all the employees from the healthcare and
#finance departments using union. Take data from the employee record table.

# Here I used the union format to bring together two fitered buckets of rows.
#The first set of rows, showed all columns for employees from the
#healthcare department. I did this by filtering with a where statement.
#Then I added the Union in its own row
#Then I added the second litle bucket of rows filtered by the
#finance department.  The union then showed them together in the 
#output table

SELECT *
FROM emp_record_table
WHERE DEPT = 'Healthcare'

UNION

SELECT *
FROM emp_record_table
WHERE DEPT = 'Finance';

#ACTION 7 Write a query to display each employee’s details—EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, 
#and EMP_RATING—along with the maximum EMP_RATING in their respective department.

#I decided to use a window function for this question because it specified I needed
# to use the aggregate MAX. This means that aggregate needd its own new row. 
#I also wanted to fiter the rows by department so the output would have those rows together.
#In the window function I incorporated the aggregate function MAX() into the
#the list of all columns I want in the output table
#THEN I used my window statement OVER(PARTITION BY)-this allowed me 
#to have the output sorted by department, as well as add the column 
#showing the max rating for each department.

SELECT EMP_ID , FIRST_NAME , LAST_NAME , ROLE, DEPT, EMP_RATING, MAX(EMP_RATING) 
	OVER(PARTITION BY DEPT) AS 'Dept Max rating'
FROM emp_record_table;

#ACTION 8 Write a query to calculate the minimum and the maximum salary of the employees 
#in each role. Take data from the employee record table.

# Here I wanted to use a window function because the problem asked to find two
#aggregates. Aggregates can only be listed in a table in a new column
#as part of a window function.
# I set up my select statement with employee name, role, and
#max and. min salary. I then tried to set up my window function.
#I decided I would use partition by instead of order by because
# I wanted to keep all of the rows even though there are overlapping roles, I 
#just wanted the ones with the same role to be grouped toether.
#This approach did not work, and I tried a few iterations before 
#rethinking the strucuture. I then went back to my notes and reviewed 
#window functions. I realized what I needed in the output was two new columns. One for max and 
#one for min so I needed to set up two window statements--one for max, and one for min.
#within each window statement I also gave each an alias so I had clear column names in the output.
#My FROM statement showed I used the employee record table.

SELECT FIRST_NAME , LAST_NAME , ROLE ,
	MAX(SALARY) OVER (PARTITION BY ROLE) AS 'role_max_salary',
	MIN(SALARY)OVER(PARTITION BY ROLE) AS 'role_min_salary'
FROM emp_record_table;

#ACTION 9 Write a query to assign ranks to each employee based on their experience. 
#Take data from the employee record table.

# Here I used the normal rank function to create a ranking system
#for seniority in the company.
# I used the ORDER BY in my OVER statement because it would put the 
#experience in an order instead of a grouping.
#I used descending order so that the person with the most experience would be
# be in row 1 and therefor be ranked #1. 


SELECT FIRST_NAME , LAST_NAME , EXP,
	RANK() OVER(ORDER BY EXP DESC) AS 'Seniority Rank'
FROM emp_record_table;

# ACTION 10-Write a query to create a view that displays employees in various 
# countries whose salary is more than six thousand. Take data from the employee record table.

# First I had to create the view by giving it the name global_salery and use AS
# to the add my query-- select statement looked for all rows, and I filtered with where >6000
#to exclude entries salaries lower than 6000. Then I ordering the rows by country.

#When checking I realized I spelled salary wrong, which I will fix afterwards.

CREATE VIEW global_salery AS
	SELECT *
	FROM emp_record_table
    WHERE salary > 6000
	ORDER BY COUNTRY;

RENAME TABLE global_salery TO global_salary;


# ACTION 11 Write a nested query to find employees with experience of more than ten years. 
#Take data from the employee record table.

# A nested query is a subquery, so I knew I had to create two different 
#query statements--inner and outer. I created the inner query to find entries by experience
#using a where statement >10 to only return employees that had over 10 years of experiences.
#Then I worked on building the outer query. The outer query
# returned all rows and filtered by the subquery of exp > 10.
#Finally I added an order by statement because I wanted to list the resulting
# employees by greatest to least experience. For me this visual orgainzation
#is really helpful when I am evaluating if my query meets the criteria of the Action.


#SELECT *
#FROM emp_record_table
#WHERE EMP_ID IN
	(SELECT *
    FROM emp_record_table
    WHERE EXP > 10)
ORDER BY EXP DESC;
    
 # ACTION 12-   Write a query using CASE WHEN in the project table to check whether the job profile assigned to each 
 # employee in the data science team matches the organization’s set standard. 
 
 # Conceptually this is like greating smaller groups based on ranges of values in a column
 # I was able to categorize correctly, but I had to play around with the syntax, until
 #I looked back at my notes/researched how exactly the ranges should be written to exclude or include
 #values within each range category.
 #I tried using BETWEEN AND a few times, which didn't work because I made a syntax error
 #where I tried to set up all the categorys in one where statement.
 #After referencing my notes, I found that I needed to specify the column name for each value in the WHEN statement.
 #Once that worked, I had to fix one more syntax error where I forgot to put a comma after SELECT*.
 #This is ironic beause I think I asked this exact question in class and  then didn't remember until after
 #lots of trial and error.
 
  SELECT * , 
		CASE 
		WHEN EXP > 0 AND EXP <= 2 THEN 'JUNIOR DATA SCIENTIST'
        WHEN EXP > 2 AND EXP <=5 THEN 'ASSOCIATE DATA SCIENTIST'
        WHEN EXP > 5 AND EXP <=10 THEN 'SENIOR DATA SCIENTIST'
        WHEN EXP > 10 AND EXP <=12 THEN 'LEAD DATA SCIENTIST'
        WHEN EXP > 12 THEN 'MANAGER'
        END
FROM emp_record_table
ORDER BY EXP;
        
# ACTION 13  Write a query to find the employee whose FIRST_NAME is ‘Eric’ in the employee table.

#This was a straight forward filtering problem. I selected all columns from the employee record
#table and then filtered by the name I was looking for and found one Mr. Eric Hoffman.

SELECT *
FROM emp_record_table
WHERE FIRST_NAME = 'Eric';      
    
    
# ACTION 14 Write a query to calculate the bonus for all the employees, 
#based on their ratings and salaries (Use the formula: 5% of salary * employee rating).    

# Since this problem involves a formula, I knew I needed to use an arithmetic function.
#I experimented where where to put it in my select statement.  
#I thought maybe it had to be a window function
#to add a new column, but when the formula was in the SELECT statement
#I saw that it automatically created its own column.
# I gave arithmetic function an alias, as it would become
#the new column name in the table
# When I looked at the output, the math was correct, but I noticed 
#only one spot in the decimal space. I wasn't able to figure out
#how to put 2 decimal places in, but when looking at the data
#none of the values had an amount beyond the decimal, so I 
#decided to keep it as is.

SELECT * , SALARY * .5 * EMP_RATING AS 'Amount Bonus'
FROM emp_record_table;



# ACTION 15  Write a query to calculate the average salary distribution based on the continent and country. 
# Take data from the employee record table.  

# First I tried to use one window function -- NTILE. I knew to use NTILE because the question
#asked for a distribution. A distribution shows the spread of values across a variable.
# I used NTILE(10), because it made sense to split the salary spread by 10% incriments.
# I thin worked on adding the continent and country filtering within the window function
#using partitition and order by, and even trying group by statements in the query.
# I tried a bunch of stuff, and the synax was not working. 
#Researching/info from notes- you can not filter a window functions by two variables in one query.
#This led me to creating a suquery so I could output a table with both the aggregate function and the filtering.
#  First I wanted to set up and test just the inner query. I wanted this one
#to show all rows and then put the salary into the distribution. Once I knew that that worked,
#I determine that my outter query needed to have the rest of the criteria--the sorting by continenet and coumtry. 
#In the outer query I also needed a window function in order to incorporate the avg salary from the inner query as well
#as display all empoloyee records in the output table. I had to create abd account for the aliases of the inner and outer query as e 
#and p. Finally I made sure aliases of window function columns were easy to understand.
# I also made sure to round the average salary to two decimal places because it is a currency value.
# WHen checking the table, I realized that there is a mistake using the window function language in the outer query
#because the country and continent orgaization was not displaying the avg salary correctly.
# Looking at my notes about partition vs order by, I realized that order by
# will create a running total instead of grouping, so I think that had something to do with
#how the output wasn't correct.  When looking up how to fix this I found out that I can partition by two variables 
# in one window function so that I can remove the order by. 


SELECT * , ROUND(AVG(SALARY) OVER(PARTITION BY CONTINENT,COUNTRY), 2) AS 'Avg Salary per Country'
	FROM (
		SELECT e.*, NTILE(10) OVER(ORDER BY SALARY DESC) AS 'Percentile by 10% incriments'
		FROM emp_record_table e ) p;
	

	



					


