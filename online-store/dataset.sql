create schema online_store;

use online_store;

CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    registration_date DATE
);

-- Sample Data
INSERT INTO Customers (first_name, last_name, email, phone, registration_date)
VALUES
('John', 'Doe', 'john.doe@example.com', '555-1234', '2021-05-15'),
('Jane', 'Smith', 'jane.smith@example.com', '555-5678', '2021-06-10'),
('Mike', 'Johnson', 'mike.johnson@example.com', '555-8765', '2021-07-20'),
('Emily', 'Davis', 'emily.davis@example.com', '555-4321', '2022-01-15');

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock_quantity INT
);

-- Sample Data
INSERT INTO Products (product_name, category, price, stock_quantity)
VALUES
('Laptop', 'Electronics', 899.99, 50),
('Smartphone', 'Electronics', 499.99, 100),
('Coffee Maker', 'Home Appliances', 79.99, 200),
('Desk Chair', 'Furniture', 149.99, 150);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Sample Data
INSERT INTO Orders (customer_id, order_date, total_amount)
VALUES
(1, '2024-01-10', 999.98),
(2, '2024-01-15', 479.98),
(3, '2024-01-20', 149.99),
(4, '2024-02-01', 249.98);

CREATE TABLE Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Sample Data
INSERT INTO Order_Items (order_id, product_id, quantity, price)
VALUES
(1, 1, 1, 899.99),
(1, 2, 1, 99.99),
(2, 2, 1, 499.99),
(3, 3, 1, 79.99),
(4, 4, 1, 149.99);



