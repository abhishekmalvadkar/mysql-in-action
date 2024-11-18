CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    low_fats CHAR(1) NOT NULL,
    recyclable CHAR(1) NOT NULL
);

INSERT INTO Products (product_id, low_fats, recyclable)
VALUES 
    (0, 'Y', 'N'),
    (1, 'Y', 'Y'),
    (2, 'N', 'Y'),
    (3, 'Y', 'Y'),
    (4, 'N', 'N');
