-- SEQUANCE
CREATE SEQUENCE record_sequence
MINVALUE 1
MAXVALUE 1000000
START WITH 1
INCREMENT BY 1
NOCYCLE;

-- AUTHOR TABLE 
-- creating the table
create table author  
( 
    author_id int not null primary key,  
    last_name varchar2(100) not null,  
    first_name varchar2(100) not null 
);

-- adding sample data
INSERT INTO author(author_id, last_name, first_name)
VALUES
(
    record_sequence.nextval, 'Christie', 'Agatha'
);

INSERT INTO author(author_id, last_name, first_name)
VALUES
(
    record_sequence.nextval, 'King', 'Stephen'
);

INSERT INTO author(author_id, last_name, first_name)
VALUES
(
    record_sequence.nextval, 'Asimov', 'Isaac'
);

INSERT INTO author(author_id, last_name, first_name)
VALUES
(
    record_sequence.nextval, 'Tolkien', 'J. R. R.'
);

INSERT INTO author(author_id, last_name, first_name)
VALUES
(
    record_sequence.nextval, 'Defoe', 'Daniel'
);

INSERT INTO author(author_id, last_name, first_name)
VALUES
(
    record_sequence.nextval, 'Backman', 'Fredrik'
);

INSERT INTO author(author_id, last_name, first_name)
VALUES
(
    record_sequence.nextval, 'Alex', 'Michaleides'
);

INSERT INTO author(author_id, last_name, first_name)
VALUES
(
    record_sequence.nextval, 'Hawking', 'Stephen'
);

INSERT INTO author(author_id, last_name, first_name)
VALUES
(
    record_sequence.nextval, 'Haig', 'Matt'
);


-- WORKS_WITH TABLE 
-- creating the table 
CREATE TABLE works_with
(
    publisher_id int NOT NULL,
    author_id int NOT NULL,
    PRIMARY KEY (publisher_id, author_id)
);

-- adding sample data
INSERT INTO works_with(publisher_id, author_id)
VALUES
(1, 3);

INSERT INTO works_with(publisher_id, author_id)
VALUES
(1, 6);

INSERT INTO works_with(publisher_id, author_id)
VALUES
(2, 5);

INSERT INTO works_with(publisher_id, author_id)
VALUES
(2, 4);

INSERT INTO works_with(publisher_id, author_id)
VALUES
(3, 9);

INSERT INTO works_with(publisher_id, author_id)
VALUES
(3, 2);

INSERT INTO works_with(publisher_id, author_id)
VALUES
(3, 3);

INSERT INTO works_with(publisher_id, author_id)
VALUES
(4, 1);

INSERT INTO works_with(publisher_id, author_id)
VALUES
(5, 8);

INSERT INTO works_with(publisher_id, author_id)
VALUES
(4, 7);


-- PUBLISHER TABLE 
-- creating the table 
create table publisher 
( 
    publisher_id int not null primary key, 
    publisher_name varchar2(100) not null, 
    phone_number varchar2(20) not null, 
    email varchar2(100) not null 
);

-- adding sample data
INSERT INTO publisher (publisher_id, publisher_name, phone_number, email)
VALUES
(1, 'Penguin Books', '123-456-7890', 'penguin@example.com');

INSERT INTO publisher (publisher_id, publisher_name, phone_number, email)
VALUES
(2, 'HarperCollins', '987-654-3210', 'harper@example.com');

INSERT INTO publisher (publisher_id, publisher_name, phone_number, email)
VALUES
(3, 'Random House', '111-222-3333', 'randomhouse@example.com');

INSERT INTO publisher (publisher_id, publisher_name, phone_number, email)
VALUES
(4, 'Simon & Schuster', '555-666-7777', 'simon@example.com');

INSERT INTO publisher (publisher_id, publisher_name, phone_number, email)
VALUES
(5, 'Hachette Book Group', '999-888-7777', 'hachette@example.com');


-- PUBLISHES TABLE 
-- creating the table 
CREATE TABLE publishes
(
    publisher_id int NOT NULL,
    isbn int NOT NULL,
    PRIMARY KEY (publisher_id, isbn)
);

-- adding sample data 
INSERT INTO publishes(publisher_id, isbn) 
VALUES 
(1, '9780451112241');

INSERT INTO publishes(publisher_id, isbn) 
VALUES 
(1, '9780385121675');

INSERT INTO publishes(publisher_id, isbn) 
VALUES
(2, '9780553293357');

INSERT INTO publishes(publisher_id, isbn)
VALUES
(3, '9780618989344');

INSERT INTO publishes(publisher_id, isbn) 
VALUES 
(4, '9781420958145');

INSERT INTO publishes(publisher_id, isbn) 
VALUES 
(5, '9781476738024');

INSERT INTO publishes(publisher_id, isbn) 
VALUES 
(4, '9781250301697');

INSERT INTO publishes(publisher_id, isbn) 
VALUES 
(3, '9780553109535');

INSERT INTO publishes(publisher_id, isbn) 
VALUES 
(2, '9780525520914');


-- DEPARTMENT TABLE 
-- creating the table 
CREATE TABLE department
(
    department_code int not null primary key,
    department_name varchar2(100) not null,
    number_of_employees int not null
);

-- adding sample data 
INSERT INTO department (department_code, department_name, number_of_employees) 
VALUES 
(1, 'Mystery/Thriller', 10);

INSERT INTO department (department_code, department_name, number_of_employees) 
VALUES 
(2, 'Horror', 10);

INSERT INTO department (department_code, department_name, number_of_employees) 
VALUES
(3, 'Science Fiction', 10);

INSERT INTO department (department_code, department_name, number_of_employees) 
VALUES 
(4, 'Adventure', 10);

INSERT INTO department (department_code, department_name, number_of_employees)
VALUES 
(5, 'Contemporary Fiction', 10);


INSERT INTO department (department_code, department_name, number_of_employees) 
VALUES 
(6, 'Science/Popular Science', 10);


-- BOOK TABLE 
-- creating the table 
CREATE TABLE book
(
    isbn varchar2(20) not null primary key,
    author_id int not null,
    department_code int not null,
    title varchar2(100) not null,
    category varchar2(100) not null,
    publication_date date not null,
    number_of_copies int not null,
    price int not null,
    CONSTRAINT fk_book_author
        FOREIGN KEY (author_id)
        REFERENCES author(author_id),
    CONSTRAINT fk_book_department
        FOREIGN KEY (department_code)
        REFERENCES department(department_code)
);

-- adding sample data 
-- Agatha Christie - Mystery/Thriller
INSERT INTO book (isbn, author_id, department_code, title, category, publication_date, number_of_copies, price)
VALUES 
('9780007113804', 1, 1, 'The Murder of Roger Ackroyd', 'Mystery/Thriller', TO_DATE('2002-06-10', 'YYYY-MM-DD'), 100, 25);

-- Stephen King - Horror
INSERT INTO book (isbn, author_id, department_code, title, category, publication_date, number_of_copies, price)
VALUES 
('9780670813029', 2, 2, 'It', 'Horror', TO_DATE('1986-09-15', 'YYYY-MM-DD'), 150, 30);

-- Isaac Asimov - Science Fiction
INSERT INTO book (isbn, author_id, department_code, title, category, publication_date, number_of_copies, price)
VALUES 
('9780553294385', 3, 3, 'Foundation', 'Science Fiction', TO_DATE('1991-06-01', 'YYYY-MM-DD'), 120, 20);

-- J.R.R. Tolkien - Adventure
INSERT INTO book (isbn, author_id, department_code, title, category, publication_date, number_of_copies, price)
VALUES 
('9780345339706', 4, 4, 'The Hobbit', 'Adventure', TO_DATE('1986-07-12', 'YYYY-MM-DD'), 200, 35);

-- Daniel Defoe - Adventure
INSERT INTO book (isbn, author_id, department_code, title, category, publication_date, number_of_copies, price)
VALUES 
('9780486264671', 5, 4, 'Robinson Crusoe', 'Adventure', TO_DATE('1997-11-10', 'YYYY-MM-DD'), 80, 15);

-- Stephen Hawking - Science
INSERT INTO book (isbn, author_id, department_code, title, category, publication_date, number_of_copies, price)
VALUES 
('9780553380163', 8, 6, 'A Brief History of Time', 'Science', TO_DATE('1998-09-01', 'YYYY-MM-DD'), 50, 40);

INSERT INTO book (isbn, author_id, department_code, title, category, publication_date, number_of_copies, price)
VALUES 
('9781476738024', 6, 5, 'A Man Called Ove', 'Fiction', TO_DATE('2014-07-15', 'YYYY-MM-DD'), 75, 28);

-- EMPLOYEE TABLE
-- creating the table 
CREATE TABLE employee
(
    personal_code varchar2(20) not null primary key,
    department_code int not null,
    salary int not null,
    commission int default null,
    last_name varchar2(100) not null,
    first_name varchar2(100) not null,
    phone_number varchar2(20) not null,
    email varchar2(100) not null,
    address varchar2(100) not null,
    CONSTRAINT fk_employee_department
        FOREIGN KEY (department_code)
        REFERENCES department(department_code)
);

-- adding sample data
INSERT INTO employee(personal_code, department_code, salary, commission, 
	last_name, first_name, phone_number, email, address)
VALUES 
('123456789', 1, 50000, NULL, 'Smith', 'John', '123-456-7890',
	 'john.smith@email.com', '123 Main St');

INSERT INTO employee(personal_code, department_code, salary, commission,
	last_name, first_name, phone_number, email, address)
VALUES 
('987654321', 2, 60000, 5, 'Johnson', 'Alice', '987-654-3210', 
	'alice.johnson@email.com', '456 Oak St');

INSERT INTO employee(personal_code, department_code, salary, commission, 
	last_name, first_name, phone_number, email, address)
VALUES 
('456789012', 3, 55000, 3, 'Davis', 'Robert', '456-789-0123', 
	'robert.davis@email.com', '789 Pine St');

INSERT INTO employee(personal_code, department_code, salary, commission, 
	last_name, first_name, phone_number, email, address)
VALUES
 ('789012345', 1, 52000, 2, 'Miller', 'Emily', '789-012-3456', 
	'emily.miller@email.com', '234 Elm St');

INSERT INTO employee(personal_code, department_code, salary, commission, 
	last_name, first_name, phone_number, email, address)
VALUES 
('567890123', 2, 58000, NULL, 'Wilson', 'David', '567-890-1234',
 'david.wilson@email.com', '567 Birch St');

INSERT INTO employee(personal_code, department_code, salary, commission, 
	last_name, first_name, phone_number, email, address)
VALUES 
('901234567', 3, 53000, 4, 'Brown', 'Sophia', '901-234-5678', 
	'sophia.brown@email.com', '890 Maple St');

INSERT INTO employee(personal_code, department_code, salary, commission,
	 last_name, first_name, phone_number, email, address)
VALUES 
('234567890', 1, 51000, NULL, 'Anderson', 'Michael', '234-567-8901', 
	'michael.anderson@email.com', '678 Cedar St');

INSERT INTO employee(personal_code, department_code, salary, commission, 
	last_name, first_name, phone_number, email, address)
VALUES 
('345678901', 2, 59000, 6, 'Davis', 'Olivia', '345-678-9012', 
	'olivia.davis@email.com', '901 Oak St');


-- COURIER_COMPANY TABLE 
-- creating the table 
CREATE TABLE courier_company
(
    company_id int NOT NULL PRIMARY KEY,
    company_name varchar2(100) NOT NULL,
    phone_number varchar(20) NOT NULL,
    email varchar2(100) NOT NULL
);

-- adding sample data
INSERT INTO courier_company (company_id, company_name, phone_number, email)
VALUES 
(1, 'FedEx', '123-456-7890', 'info@fedex.com');

INSERT INTO courier_company (company_id, company_name, phone_number, email)
VALUES 
(2, 'UPS', '987-654-3210', 'info@ups.com');

INSERT INTO courier_company (company_id, company_name, phone_number, email)
VALUES 
(3, 'DHL', '555-123-4567', 'info@dhl.com');

INSERT INTO courier_company (company_id, company_name, phone_number, email)
VALUES 
(4, 'USPS', '888-999-0000', 'info@usps.com');

INSERT INTO courier_company (company_id, company_name, phone_number, email)
VALUES 
(5, 'TNT Express', '333-555-7777', 'info@tntexpress.com');


-- COURIER TABLE 
-- creating the table 
CREATE TABLE courier_company
(
    company_id int NOT NULL PRIMARY KEY,
    company_name varchar2(100) NOT NULL,
    phone_number varchar(20) NOT NULL,
    email varchar2(100) NOT NULL
);

-- adding sample data 
INSERT INTO courier (courier_id, company_id, last_name, first_name, phone_number, email)
VALUES
(1, 1, 'Smith', 'John', '123-456-7890', 'john.smith@example.com');

INSERT INTO courier (courier_id, company_id, last_name, first_name, phone_number, email)
VALUES
(2, 2, 'Johnson', 'Emma', '987-654-3210', 'emma.johnson@example.com');

INSERT INTO courier (courier_id, company_id, last_name, first_name, phone_number, email)
VALUES
(3, 3, 'Williams', 'Michael', '555-123-4567', 'michael.williams@example.com');

INSERT INTO courier (courier_id, company_id, last_name, first_name, phone_number, email)
VALUES
(4, 1, 'Davis', 'Sophia', '111-222-3333', 'sophia.davis@example.com');

INSERT INTO courier (courier_id, company_id, last_name, first_name, phone_number, email)
VALUES
(5, 2, 'Anderson', 'Daniel', '999-888-7777', 'daniel.anderson@example.com');


--CLIENT TABLE 
-- creating the table
CREATE TABLE client
(
    client_id int not null primary key,
    phone_number varchar2(20) not null,
    email varchar2(100) not null,
    address varchar2(100) not null
);

-- adding sample data
INSERT INTO client (client_id, phone_number, email, address)  
VALUES 
(1, '555-1234', 'contact@realbooklight.com', '123 Main St');

INSERT INTO client (client_id, phone_number, email, address)  
VALUES 
(2, '555-5678', 'contact@clearglow.com', '456 Oak St');

INSERT INTO client (client_id, phone_number, email, address)  
VALUES 
(3, '555-9101', 'contact@atutobookcase.com', '789 Pine St');

INSERT INTO client (client_id, phone_number, email, address)  
VALUES 
(4, '555-2345', 'mary-smith@example.com', '101 Elm St');

INSERT INTO client (client_id, phone_number, email, address)  
VALUES 
(5, '555-6789', 'john-doe@example.com', '202 Birch St');

INSERT INTO client (client_id, phone_number, email, address)  
VALUES 
(6, '555-1122', 'emily-jones@example.com', '303 Maple St');

INSERT INTO client (client_id, phone_number, email, address)  
VALUES 
(7, '555-3344', 'contact@novelhaven.com', '404 Cedar St');

INSERT INTO client (client_id, phone_number, email, address)  
VALUES 
(8, '555-5566', 'contact@fictionemporium.com', '505 Walnut St');

INSERT INTO client (client_id, phone_number, email, address)
VALUES 
(9, '555-7788', 'contact@whimsicalreads.com', '606 Spruce St');

INSERT INTO client (client_id, phone_number, email, address)
VALUES 
(10, '555-9900', 'contact@dreamybooks.com', '707 Ash St');

INSERT INTO client (client_id, phone_number, email, address) 
VALUES 
(11, '555-1122', 'noah-wilson@example.com', '808 Oak St');

INSERT INTO client (client_id, phone_number, email, address) 
VALUES 
(12, '555-3344', 'sophia-miller@example.com', '909 Pine St');

INSERT INTO client (client_id, phone_number, email, address) 
VALUES 
(13, '555-5566', 'jackson-jones@example.com', '1010 Birch St');

INSERT INTO client (client_id, phone_number, email, address)
VALUES 
(14, '555-7788', 'emma-martin@example.com', '1111 Maple St');

INSERT INTO client (client_id, phone_number, email, address)
VALUES 
(15, '555-9900', 'aiden-thomas@example.com', '1212 Cedar St');

INSERT INTO client (client_id, phone_number, email, address)  
VALUES 
(16, '555-1122', 'olivia-jackson@example.com', '1313 Walnut St');

INSERT INTO client (client_id, phone_number, email, address) 
VALUES 
(17, '555-3344', 'liam-brown@example.com', '1414 Spruce St');

INSERT INTO client (client_id, phone_number, email, address) 
VALUES 
(18, '555-1111', 'contact@bookmagic.com', '808 Elm St');

INSERT INTO client (client_id, phone_number, email, address)  
VALUES 
(19, '555-2222', 'contact@enchantingbooks.com', '909 Oak St');

INSERT INTO client (client_id, phone_number, email, address) 
VALUES 
(20, '555-3333', 'contact@imaginativepress.com', '101 Pine St');


-- INDIVIDUAL TABLE
-- creating the table 
create table individual
(
client_id int not null primary key,
last_name varchar2(100) not null,
first_name varchar2(100) not null
);

-- adding sample data
INSERT INTO individual(client_id, last_name, first_name)
VALUES 
(4, 'Smith', 'Mary');

INSERT INTO  individual(client_id, last_name, first_name)
VALUES 
(5, 'Doe', 'John');

INSERT INTO  individual(client_id, last_name, first_name)
VALUES 
(6, 'Jones', 'Emily');

INSERT INTO  individual(client_id, last_name, first_name)
VALUES 
(11, 'Wilson', 'Noah');

INSERT INTO  individual(client_id, last_name, first_name)
VALUES 
(12, 'Miller', 'Sophia');

INSERT INTO  individual(client_id, last_name, first_name)
VALUES 
(13, 'Jones', 'Jackson');

INSERT INTO  individual(client_id, last_name, first_name)
VALUES 
(14, 'Martin', 'Emma');

INSERT INTO  individual(client_id, last_name, first_name)
VALUES 
(15, 'Thomas', 'Aiden');

INSERT INTO  individual(client_id, last_name, first_name)
VALUES 
(16, 'Jackson', 'Olivia');

INSERT INTO individual(client_id, last_name, first_name)
VALUES 
(17, 'Brown', 'Liam');


-- COMPANY TABLE 
-- creating the table 
CREATE TABLE company
(
    client_id int not null primary key,
    name varchar2(100) not null,
    representative_last_name varchar2(100) not null,
    representative_first_name varchar2(100) not null,
    representative_function varchar2(100) not null
);

-- adding sample data 
INSERT INTO company (client_id, name, representative_last_name, representative_first_name, representative_function)
VALUES (1, 'RealBookLight', 'Rodriguez', 'Elena', 'CEO');

INSERT INTO company (client_id, name, representative_last_name, representative_first_name, representative_function)
VALUES (2, 'ClearGlow', 'Mendez', 'Carlos', 'Manager');

INSERT INTO company (client_id, name, representative_last_name, representative_first_name, representative_function)
VALUES (3, 'AutoBookcase', 'Garcia', 'Sofia', 'Director');

INSERT INTO company (client_id, name, representative_last_name, representative_first_name, representative_function)
VALUES (7, 'NovelHeaven', 'Martinez', 'Javier', 'President');

INSERT INTO company (client_id, name, representative_last_name, representative_first_name, representative_function)
VALUES (8, 'FictionEmporium', 'Turner', 'Liam', 'Manager');

INSERT INTO company (client_id, name, representative_last_name, representative_first_name, representative_function)
VALUES (9, 'WhimsicalReads', 'Walker', 'Ethan', 'CEO');

INSERT INTO company (client_id, name, representative_last_name, representative_first_name, representative_function)
VALUES (10, 'DreamyBooks', 'Thomas', 'Aiden', 'Manager');

INSERT INTO company (client_id, name, representative_last_name, representative_first_name, representative_function)
VALUES (18, 'BookMagic', 'Brown', 'Liam', 'Director');

INSERT INTO company (client_id, name, representative_last_name, representative_first_name, representative_function)
VALUES (19, 'EnchantingBooks', 'Wilson', 'Noah', 'CEO');

INSERT INTO company (client_id, name, representative_last_name, representative_first_name, representative_function)
VALUES (20, 'ImaginativePress', 'Jackson', 'Olivia', 'Manager');


-- CLIENT_ORDER TABLE 
-- creating the table 
CREATE TABLE client_order
(
    order_code int not null primary key,
    courier_id int not null,
    client_id int not null,
    payment_method varchar2(20) not null,
    number_of_products int not null,
    CONSTRAINT fk_client_order_courier
        FOREIGN KEY (courier_id)
        REFERENCES courier (courier_id),
    CONSTRAINT fk_client_order_client
        FOREIGN KEY (client_id)
        REFERENCES client (client_id)
);

-- adding sample data 
INSERT INTO client_order (order_code, courier_id, client_id, payment_method, number_of_products) 
    VALUES 
    (1, 1, 4, 'Credit Card', 3);
INSERT INTO client_order (order_code, courier_id, client_id, payment_method, number_of_products) 
    VALUES
    (2, 2, 5, 'Cash', 2);
INSERT INTO client_order (order_code, courier_id, client_id, payment_method, number_of_products) 
    VALUES 
    (3, 3, 6, 'PayPal', 1);
INSERT INTO client_order (order_code, courier_id, client_id, payment_method, number_of_products) 
    VALUES
    (4, 4, 7, 'Credit Card', 4);
INSERT INTO client_order (order_code, courier_id, client_id, payment_method, number_of_products)
    VALUES 
    (5, 5, 8, 'Cash', 2);
INSERT INTO client_order (order_code, courier_id, client_id, payment_method, number_of_products) 
    VALUES 
    (6, 1, 11, 'Credit Card', 3);
INSERT INTO client_order (order_code, courier_id, client_id, payment_method, number_of_products) 
    VALUES 
    (7, 2, 12, 'Cash', 2);
INSERT INTO client_order (order_code, courier_id, client_id, payment_method, number_of_products) 
    VALUES 
    (8, 3, 13, 'PayPal', 1);
INSERT INTO client_order (order_code, courier_id, client_id, payment_method, number_of_products) 
    VALUES 
    (9, 4, 14, 'Credit Card', 4);
INSERT INTO client_order (order_code, courier_id, client_id, payment_method, number_of_products) 
    VALUES 
    (10, 5, 15, 'Cash', 2);


-- IS_PART_OF TABLE 
-- creating the table 
create table is_part_of
(
    isbn int not null,
    order_code int not null,
    number_of_copies int not null,
    primary key(isbn, order_code)
);

-- adding sample data
INSERT INTO is_part_of (isbn, order_code, number_of_copies)
VALUES ('9780007113804', 1, 2);

INSERT INTO is_part_of (isbn, order_code, number_of_copies)
VALUES ('9780670813029', 1, 1);
INSERT INTO is_part_of (isbn, order_code, number_of_copies)
VALUES ('9780670813029', 2, 2);

INSERT INTO is_part_of (isbn, order_code, number_of_copies)
VALUES ('9780553294385', 3, 1);

INSERT INTO is_part_of (isbn, order_code, number_of_copies)
VALUES ('9780345339706', 4, 1);
INSERT INTO is_part_of (isbn, order_code, number_of_copies)
VALUES ('9780553294385', 4, 1);
INSERT INTO is_part_of (isbn, order_code, number_of_copies)
VALUES ('9780670813029', 4, 1);
INSERT INTO is_part_of (isbn, order_code, number_of_copies)
VALUES ('9780486264671', 4, 1);

INSERT INTO is_part_of (isbn, order_code, number_of_copies)
VALUES ('9780486264671', 5, 2);

INSERT INTO is_part_of (isbn, order_code, number_of_copies)
VALUES ('9780007113804', 6, 1);
INSERT INTO is_part_of (isbn, order_code, number_of_copies)
VALUES ('9780670813029', 6, 1);
INSERT INTO is_part_of (isbn, order_code, number_of_copies)
VALUES ('9780486264671', 6, 1);

INSERT INTO is_part_of (isbn, order_code, number_of_copies)
VALUES ('9780670813029', 7, 2);

INSERT INTO is_part_of (isbn, order_code, number_of_copies)
VALUES ('9780553294385', 8, 1);

INSERT INTO is_part_of (isbn, order_code, number_of_copies)
VALUES ('9780345339706', 9, 4);

INSERT INTO is_part_of (isbn, order_code, number_of_copies)
VALUES ('9780486264671', 10, 2);