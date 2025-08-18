-- Drop and Create Database
DROP DATABASE IF EXISTS librarydb;
CREATE DATABASE librarydb;
USE librarydb;

-- Table 1: Authors
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(50)
);

-- Table 2: Books
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    genre VARCHAR(50),
    author_id INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

-- Table 3: Members
CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    borrowed_book INT,
    FOREIGN KEY (borrowed_book) REFERENCES Books(book_id)
);

-- Data Generator Procedure
DELIMITER $$

CREATE PROCEDURE populate_dummy_data()
BEGIN
    DECLARE i INT DEFAULT 1;

    -- Insert 100 Authors
    SET i = 1;
    WHILE i <= 100 DO
        INSERT INTO Authors (name, country)
        VALUES (
            CONCAT('Author_', i),
            ELT(FLOOR(1 + (RAND() * 5)), 'USA', 'UK', 'India', 'Canada', 'Australia')
        );
        SET i = i + 1;
    END WHILE;

    -- Insert 1000 Books
    SET i = 1;
    WHILE i <= 1000 DO
        INSERT INTO Books (title, genre, author_id)
        VALUES (
            CONCAT('Book_', i),
            ELT(FLOOR(1 + (RAND() * 5)), 'Fantasy', 'Fiction', 'Sci-Fi', 'Romance', 'Thriller'),
            FLOOR(1 + RAND() * 100)
        );
        SET i = i + 1;
    END WHILE;

    -- Insert 10000 Members
    SET i = 1;
    WHILE i <= 10000 DO
        INSERT INTO Members (full_name, email, borrowed_book)
        VALUES (
            CONCAT('Member_', i),
            CONCAT('member', i, '@example.com'),
            FLOOR(1 + RAND() * 1000)
        );
        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;

-- Call the procedure
CALL populate_dummy_data();

-- Drop procedure (optional cleanup)
DROP PROCEDURE populate_dummy_data;


