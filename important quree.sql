desc user; 
select * from user; 	
select * from publictransportmanager;
select * from analyticsandreporting;
select * from bikesharingmanager;
select * from environmentimpacttracking;
select * from parkingmanagement;
select * from systemmonitor;
select * from trafficmonitor;

ALTER TABLE TrafficMonitor DROP PRIMARY KEY;
ALTER TABLE TrafficMonitor DROP COLUMN monitor_id;

-- Step 1: Database Management
CREATE DATABASE IF NOT EXISTS my_database; -- Create a database
USE my_database; -- Select the database

-- Step 2: Table Management
-- Create a table
CREATE TABLE IF NOT EXISTS User (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(50),
    password VARCHAR(255),
    type ENUM('Admin', 'User') DEFAULT 'User',
    permissions VARCHAR(50) DEFAULT 'Basic',
    role VARCHAR(50),
    monitor_status BOOLEAN DEFAULT FALSE
);

-- Show all tables
SHOW TABLES;

-- Describe table structure
DESCRIBE User;

-- Add a new column
ALTER TABLE User ADD COLUMN last_login DATETIME;

-- Drop a column
ALTER TABLE User DROP COLUMN last_login;

-- Step 3: Data Manipulation
-- Insert a single row
INSERT INTO User (email, phone, password, type, permissions, role, monitor_status)
VALUES ('admin@example.com', '123-456-7890', 'securepassword', 'Admin', 'Full', 'Manager', TRUE);

-- Insert multiple rows
INSERT INTO User (email, phone, password, type, permissions, role, monitor_status)
VALUES
('user1@example.com', '987-654-3210', 'password123', 'User', 'Limited', 'Staff', FALSE),
('user2@example.com', '456-789-0123', 'password456', 'User', 'Basic', 'Staff', TRUE);

-- Update data
UPDATE User
SET monitor_status = TRUE
WHERE type = 'Admin';

-- Delete data
DELETE FROM User
WHERE email = 'user2@example.com';

-- Truncate table (delete all data)
TRUNCATE TABLE User;

-- Step 4: Querying Data
-- Select specific columns
SELECT user_id, email, type FROM User;

-- Filter with conditions
SELECT * FROM User WHERE monitor_status = TRUE;

-- Sort data
SELECT * FROM User ORDER BY email ASC;

-- Aggregate functions
SELECT COUNT(*) AS TotalUsers FROM User;
SELECT MAX(user_id) AS MaxUserID FROM User;

-- Group by query
SELECT type, COUNT(*) AS CountByType FROM User GROUP BY type;

-- Step 5: Joins
-- Create another table
CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    product VARCHAR(255),
    quantity INT,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Insert into Orders
INSERT INTO Orders (user_id, product, quantity)
VALUES
(1, 'Laptop', 1),
(1, 'Mouse', 2),
(2, 'Keyboard', 1);

-- Perform an inner join
SELECT u.user_id, u.email, o.product, o.quantity
FROM User u
INNER JOIN Orders o ON u.user_id = o.user_id;

-- Step 6: Indexing
-- Create an index
CREATE INDEX idx_email ON User(email);

-- Drop an index
DROP INDEX idx_email ON User;

-- Step 7: Constraints
-- Add a unique constraint
ALTER TABLE User ADD CONSTRAINT unique_phone UNIQUE (phone);

-- Step 8: Transactions
-- Start a transaction
START TRANSACTION;

-- Perform multiple operations
INSERT INTO User (email, phone, password, type, permissions, role, monitor_status)
VALUES ('temp@example.com', '111-222-3333', 'temppass', 'User', 'Basic', 'Staff', FALSE);

ROLLBACK; -- Rollback transaction (undo changes)

COMMIT; -- Commit transaction (save changes)

-- Step 9: Backup and Restore
-- Backup (mysqldump) and restore commands are run from the command line, not in SQL scripts.

-- Step 10: User Management
-- Create a new user
CREATE USER 'new_user'@'localhost' IDENTIFIED BY 'new_password';

-- Grant privileges
GRANT ALL PRIVILEGES ON my_database.* TO 'new_user'@'localhost';


-- Drop a user
DROP USER 'new_user'@'localhost';

-- Step 11: Dropping Table or Database
-- Drop a table
DROP TABLE IF EXISTS Orders;

-- Drop the database
DROP DATABASE IF EXISTS my_database;
