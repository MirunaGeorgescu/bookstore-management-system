
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

