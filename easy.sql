-- 175 combine two tables
SELECT Firstname, Lastname, City, State
FROM Person
LEFT JOIN Address ON Person.PersonID = Address.PersonID;

-- 176 second highest salary
SELECT 
    IFNULL(
        (
            SELECT DISTINCT Salary as SecondHighestSalary FROM Employee
            ORDER BY Salary DESC
            LIMIT 1 OFFSET 1
        ), 
        null
    ) as SecondHighestSalary;

-- 181 employees earning more than their managers
SELECT A.Name AS Employee FROM Employee as A
INNER JOIN Employee as B
ON A.ManagerId = B.Id
WHERE A.Salary > B.Salary;

-- 182 duplicate emails
SELECT Email from{
    SELECT Email, count(Email) as num 
    FROM Person
}
WHERE num>1;

-- 183 customers who never order
SELECT Name as 'Customers'
FROM Customers
WHERE Id NOT IN(
    SELECT CustomerId FROM Orders
);

-- 196 delete duplicate email
DELETE P1 FROM Person as P1, Person as P2
WHERE P1.Email = P2.Email AND P1.Id > P2.Id;

-- 197 rising temperature
SELECT w1.Id as Id FROM Weather as w1
JOIN Weather as w2
ON DATEDIFF(w1.RecordDate, w2.RecordDate) = 1 AND w1.Temperature > w2.Temperature;

-- 595 big country
SELECT name, population,area FROM World
WHERE area > 3000000 OR population > 25000000;

-- 596 classes more than 5 students
SELECT class FROM courses
GROUP BY class
having count(DISTINCT Student) > 4
ORDER BY count(DISTINCT Student) DESC;

-- 620 not boring movies
SELECT * FROM cinema
WHERE deccription <> 'boring' AND id % 2 = 1
ORDER BY rating DESC;

-- 627 swap salary
UPDATE salary 
SET
    sex = CASE sex
        WHEN 'm' THEN 'f'
        ELSE 'm'
    END;






