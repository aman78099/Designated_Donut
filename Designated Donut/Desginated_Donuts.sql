--
-- File generated with SQLiteStudio v3.4.4 on Fri May 8 13:16:59 2026
--
-- Text encoding used: System
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: Order Items
CREATE TABLE IF NOT EXISTS `Order Items` (
  `order_item_id` int,
  `order_id` int,
  `product_id` int,
  `quantity` int,
  `purchase_price` decimal,
  PRIMARY KEY (`order_item_id`),
  FOREIGN KEY (`product_id`)
      REFERENCES `Products`(`product_id`),
  FOREIGN KEY (`order_id`)
      REFERENCES `Orders`(`order_id`)
);
INSERT INTO "Order Items" (order_item_id, order_id, product_id, quantity, purchase_price) VALUES (5999203886, 1001, 382, 2, 10);
INSERT INTO "Order Items" (order_item_id, order_id, product_id, quantity, purchase_price) VALUES (5999203887, 1002, 901, 3, 15);
INSERT INTO "Order Items" (order_item_id, order_id, product_id, quantity, purchase_price) VALUES (5999203888, 1003, 156, 4, 20);
INSERT INTO "Order Items" (order_item_id, order_id, product_id, quantity, purchase_price) VALUES (5999203889, 1004, 432, 5, 25);
INSERT INTO "Order Items" (order_item_id, order_id, product_id, quantity, purchase_price) VALUES (5999203890, 1005, 393, 6, 30);
INSERT INTO "Order Items" (order_item_id, order_id, product_id, quantity, purchase_price) VALUES (5999203891, 1006, 453, 7, 35);
INSERT INTO "Order Items" (order_item_id, order_id, product_id, quantity, purchase_price) VALUES (5999203892, 1007, 766, 8, 40);
INSERT INTO "Order Items" (order_item_id, order_id, product_id, quantity, purchase_price) VALUES (5999203893, 1008, 765, 9, 45);
INSERT INTO "Order Items" (order_item_id, order_id, product_id, quantity, purchase_price) VALUES (5999203894, 1009, 256, 10, 50);
INSERT INTO "Order Items" (order_item_id, order_id, product_id, quantity, purchase_price) VALUES (5999203895, 1010, 414, 11, 55);
INSERT INTO "Order Items" (order_item_id, order_id, product_id, quantity, purchase_price) VALUES (5999203896, 1011, 849, 12, 60);
INSERT INTO "Order Items" (order_item_id, order_id, product_id, quantity, purchase_price) VALUES (5999203897, 1012, 237, 13, 65);

-- Table: Orders
CREATE TABLE IF NOT EXISTS `Orders` (
  `order_id` int,
  `user_id` int,
  `order_date` date,
  `total_price` decimal,
  PRIMARY KEY (`order_id`),
  FOREIGN KEY (`user_id`)
      REFERENCES `Users`(`user_id`)
);
INSERT INTO Orders (order_id, user_id, order_date, total_price) VALUES (1001, 121, '04/12/2023', 10);
INSERT INTO Orders (order_id, user_id, order_date, total_price) VALUES (1002, 122, '19/08/2025', 15);
INSERT INTO Orders (order_id, user_id, order_date, total_price) VALUES (1003, 123, '01/01/2024', 20);
INSERT INTO Orders (order_id, user_id, order_date, total_price) VALUES (1004, 124, '27/11/2022', 25);
INSERT INTO Orders (order_id, user_id, order_date, total_price) VALUES (1005, 125, '15/05/2026', 30);
INSERT INTO Orders (order_id, user_id, order_date, total_price) VALUES (1006, 126, '03/09/2021', 35);
INSERT INTO Orders (order_id, user_id, order_date, total_price) VALUES (1007, 127, '22/02/2028', 40);
INSERT INTO Orders (order_id, user_id, order_date, total_price) VALUES (1008, 128, '10/07/2024', 45);
INSERT INTO Orders (order_id, user_id, order_date, total_price) VALUES (1009, 129, '30/03/2023', 50);
INSERT INTO Orders (order_id, user_id, order_date, total_price) VALUES (1010, 130, '14/10/2025', 55);
INSERT INTO Orders (order_id, user_id, order_date, total_price) VALUES (1011, 131, '02/11/2022', 60);
INSERT INTO Orders (order_id, user_id, order_date, total_price) VALUES (1012, 132, '14/06/2024', 65);

-- Table: Products
CREATE TABLE IF NOT EXISTS `Products` (
  `product_id` int,
  `product_name` varchar(50),
  `product_type` varchar(50),
  `price` decimal,
  PRIMARY KEY (`product_id`)
);
INSERT INTO Products (product_id, product_name, product_type, price) VALUES (382, 'Blueberry Blast', 'Blue Donut', 5);
INSERT INTO Products (product_id, product_name, product_type, price) VALUES (901, 'Midnight Cocoa', 'Black Donut', 5);
INSERT INTO Products (product_id, product_name, product_type, price) VALUES (156, 'Vanilla Frost', 'White Donut', 5);
INSERT INTO Products (product_id, product_name, product_type, price) VALUES (432, 'Sky Glaze', 'Blue Donut', 5);
INSERT INTO Products (product_id, product_name, product_type, price) VALUES (393, 'Dark Velvet', 'Black Donut', 5);
INSERT INTO Products (product_id, product_name, product_type, price) VALUES (453, 'Powdered Pearl', 'White Donut', 5);
INSERT INTO Products (product_id, product_name, product_type, price) VALUES (766, 'Ocean Ring', 'Blue Donut', 5);
INSERT INTO Products (product_id, product_name, product_type, price) VALUES (765, 'Inkwell Sweet', 'Black Donut', 5);
INSERT INTO Products (product_id, product_name, product_type, price) VALUES (256, 'Cloud Nibble', 'White Donut', 5);
INSERT INTO Products (product_id, product_name, product_type, price) VALUES (414, 'Azure Loop', 'Blue Donut', 5);
INSERT INTO Products (product_id, product_name, product_type, price) VALUES (849, 'Coal Crunch', 'Black Donut', 5);
INSERT INTO Products (product_id, product_name, product_type, price) VALUES (237, 'Snowy Swirl', 'White Donut', 5);

-- Table: user_sessions
CREATE TABLE IF NOT EXISTS `user_sessions` (
  `session_id` int,
  `user_id` int,
  `login_times` datetime,
  PRIMARY KEY (`session_id`),
  FOREIGN KEY (`user_id`)
      REFERENCES `Users`(`user_id`)
);
INSERT INTO user_sessions (session_id, user_id, login_times) VALUES (86, 121, '2024-01-01 10:00:00');
INSERT INTO user_sessions (session_id, user_id, login_times) VALUES (64, 122, '2024-01-01 12:00:00');
INSERT INTO user_sessions (session_id, user_id, login_times) VALUES (76, 123, '2024-01-01 14:00:00');
INSERT INTO user_sessions (session_id, user_id, login_times) VALUES (48, 124, '2024-01-01 16:00:00');
INSERT INTO user_sessions (session_id, user_id, login_times) VALUES (65, 125, '2024-01-01 18:00:00');
INSERT INTO user_sessions (session_id, user_id, login_times) VALUES (37, 126, '2024-01-01 20:00:00');
INSERT INTO user_sessions (session_id, user_id, login_times) VALUES (59, 127, '2024-01-01 22:00:00');
INSERT INTO user_sessions (session_id, user_id, login_times) VALUES (82, 128, '2024-01-02 00:00:00');
INSERT INTO user_sessions (session_id, user_id, login_times) VALUES (84, 129, '2024-01-02 02:00:00');
INSERT INTO user_sessions (session_id, user_id, login_times) VALUES (62, 130, '2024-01-02 04:00:00');
INSERT INTO user_sessions (session_id, user_id, login_times) VALUES (87, 131, '2024-05-15 08:30:15');
INSERT INTO user_sessions (session_id, user_id, login_times) VALUES (58, 132, '2024-06-20 13:45:00');

-- Table: Users
CREATE TABLE IF NOT EXISTS `Users` (
  `user_id` int,
  `name` varchar(50),
  `email` varchar(50) UNIQUE,
  `password` varchar,
  PRIMARY KEY (`user_id`)
);
INSERT INTO Users (user_id, name, email, password) VALUES (121, 'Liam', 'liam@email.com', 'iXmMX6Z5b2');
INSERT INTO Users (user_id, name, email, password) VALUES (122, 'Sophia', 'sophia@email.com', '!I1^SqB^TJ');
INSERT INTO Users (user_id, name, email, password) VALUES (123, 'Mateo', 'mateo@email.com', '#4YTIs4mTi');
INSERT INTO Users (user_id, name, email, password) VALUES (124, 'Elena', 'elena@email.com', 'frw$i2YGgB');
INSERT INTO Users (user_id, name, email, password) VALUES (125, 'Julian', 'julian@email.com', '$g4u3KLizB');
INSERT INTO Users (user_id, name, email, password) VALUES (126, 'Naomi', 'naomi@email.com', 'ovUwsA#$Yw');
INSERT INTO Users (user_id, name, email, password) VALUES (127, 'Silas', 'silas@email.com', '7@EbjrvQ^A');
INSERT INTO Users (user_id, name, email, password) VALUES (128, 'Maya', 'maya@email.com', 'Bs5cZpsrZs');
INSERT INTO Users (user_id, name, email, password) VALUES (129, 'Caleb', 'caleb@email.com', 'Q5U$%87Ow9');
INSERT INTO Users (user_id, name, email, password) VALUES (130, 'Lila', 'lila@email.com', '#WFUWyY&0Q');
INSERT INTO Users (user_id, name, email, password) VALUES (131, 'Felix', 'felix@email.com', 'bV5&sD1@fG');
INSERT INTO Users (user_id, name, email, password) VALUES (132, 'Zara', 'zara@email.com', '7mY$jH3^qW');

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;