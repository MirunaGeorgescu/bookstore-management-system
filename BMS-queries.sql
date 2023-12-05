/*SQL Queries and Operations*/
/*Display, for each department, the publisher where the most recent book was published.*/
-- MRB stands for Most Recent Book
WITH MRB (MRB_book, MRB_dep) AS (
    -- query block used to find the most recent publication date (the minimum number 
    -- of months since publication) for each department
    SELECT
        MIN(ROUND(MONTHS_BETWEEN(SYSDATE, book.publication_date))),
        department.department_code
    FROM
        book, department
    WHERE
    	-- joining the tables BOOK and DEPARTMENT on department_code
        book.department_code = department.department_code
    GROUP BY
        department.department_code
)
-- main query used to find the department name and the publishing house 
-- name for the most recent books
SELECT
    d.department_name,
    e.publisher_name
FROM
    department d, publisher e, book b, publishes p, MRB
WHERE
    -- joining the tables based on department_code, isbn and publisher_id
    d.department_code = b.department_code AND
    b.isbn = p.isbn AND
    p.publisher_id = e.publisher_id AND
    -- filtering by department and by the number of months passed since publication
    d.department_code = MRB.MRB_dep AND
    ROUND(MONTHS_BETWEEN(SYSDATE, b.publication_date)) = MRB.MRB_book;


/* Display in alphabetical order the categories to which the three cheapest books sold by the bookstore belong. */
WITH cheapest_books AS (
	-- selecting only the first 3 titles 
    SELECT title
	FROM (
        -- selecting the titles, ordered by price
		SELECT title
		FROM book
		ORDER BY price
		) WHERE rownum < 4
)
-- selecting the titles for the books that have titles in cheapest_books
SELECT category
FROM book
WHERE title IN (
	SELECT title
	FROM cheapest_books
)
ORDER BY category ASC;


/* Display the name, salary, and commission (if not available, display 'no commission') 
of employees whose salary is higher than the salary of the employee who receives a higher commission than Alice. */
-- selecting the name and salary of thr employee who earnes a salary highter than 
-- the salary of the employee who earnes a commission higher
-- than the commission earned by alice
SELECT first_name || ' ' || last_name AS name, salary,
       -- NVL: if commission is null then 'no commission'
       NVL(TO_CHAR(commission), 'no commission') AS commission
FROM employee
WHERE salary > ( -- selecting the salary of the employee who earnes a commission higher
                 -- than the commission earned by alice
    			 SELECT salary
                 FROM employee
                 WHERE commission > ( -- selecting the commission earned by the employee whose name is Alice
    							   SELECT commission 
                                   FROM employee
                                   WHERE LOWER(first_name) = 'alice'));


/* Display the name, commission, and commission type (if not available, "Employee doesn't earn commission", if greater than 4, 
"Employee earns a high commission", or if less than or equal to 5, "Employee earns a low commission") of employees working in 
departments with more employees than the department where the book with the longest title is located. */
-- selecting the name and commission types for the employees 
SELECT first_name || ' ' || last_name AS name, commission,
       CASE
           WHEN commission IS NULL THEN 'Employee doesnt earn commission'
           WHEN commission > 4 THEN 'Employee earns a high commission'
           ELSE 'Employee earns a low commission'
       END AS "COMMISSION TYPE"
FROM employee
WHERE department_code IN (
    -- selecting the department codes for the departments with more employees than the one selected prior 
    SELECT department_code
    FROM department
    WHERE number_of_employees > (
    	-- selecting the number of employees for the department 
        SELECT number_of_employees
        FROM department
        WHERE department_code = (
    		-- selecting the department code for the department in which the book with the longest title is in 
            SELECT department_code
            FROM book
            WHERE LENGTH(title) = (
    			-- selecting the length of the longest title 
                SELECT MAX(LENGTH(title))
                FROM book
            )
        )
    )
);

/* Inflation causes the increase of all prices, and books are no exception. Therefore, the prices of books
in the Science department increase by 2%, the prices of books in the Adventure department increase by 3%, 
and for the rest of the books, the prices increase by 5%. Display the title, price before the increase, 
and price after the increase of the books, as well as the department they belong to. */
SELECT
    title,
    department.department_name AS "DEPARTMENT NAME",
    price,
    DECODE(
    	-- depending on the department, the change is applied 
        LOWER(department.department_name),
        'science', price + price * 2 / 100,
        'adventure', price + price * 3 / 100,
        price + price * 5 / 100
    ) AS "PRICE AFTER INCREASE"
FROM
    book
INNER JOIN
    -- joining the BOOK table and the DEPARTMENT table on department_code 
    department ON department.department_code = book.department_code
ORDER BY
    -- ordering alphabetically by department name 
    department.department_name ASC;


/*Operations Using Subqueries*/
/* Modify the job title for all representatives of the company whose id is greater than 10. */
UPDATE company 
SET representative_function = 'HR Manager'
WHERE client_id > 10;

/* All employees whose last name contains the sequence 'son' receive a promotion!
   Their salary is increased by 30%, and if they receive a commission, it is increased by a certain percentage.
    Modify the mentioned columns. */
UPDATE employee
SET salary = salary + salary * 30/100,
    commission = commission + 1
WHERE lower(last_name) LIKE '%son%';

/*The most expensive books in the bookstore are on sale for 15% off for a limited time! Update the prices.*/
UPDATE book
SET price = price - price * 15/100
WHERE price = (SELECT MAX(price)
               FROM book);
