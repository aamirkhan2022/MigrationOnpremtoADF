
USE OnPremDB;

DROP TABLE CATEGORIES;

DELETE FROM CATEGORIES;

CREATE TABLE CATEGORIES (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255),
	created_at DATETIME,
    updated_at DATETIME
);

INSERT INTO Categories (category_id, category_name,created_at,updated_at)
VALUES
 --(1, 'Electronics',GETDATE(),GETDATE()),
 --(2, 'Clothing',GETDATE(),GETDATE())
 (3, 'Furniture',GETDATE(),GETDATE()),
 (4, 'Books',GETDATE(),GETDATE()),
 (5, 'Sports', GETDATE(), GETDATE()),
 (6, 'Accessories', GETDATE(), GETDATE()),
 (7, 'Technology', GETDATE(), GETDATE())
	


SELECT * FROM CATEGORIES;

DROP TABLE Customers;

-- Create the Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name NVARCHAR(255),
    last_name NVARCHAR(255),
    email NVARCHAR(255) UNIQUE,    
    created_at DATETIME,
    updated_at DATETIME
);

---- Insert records into the Customers table
-- INSERT INTO Customers (customer_id, first_name, last_name, email, created_at,updated_at) VALUES
--(100, 'John', 'Doe', 'john.doe@example.com', GETDATE(),GETDATE())	

--INSERT INTO Customers (customer_id, first_name, last_name, email, created_at,updated_at) VALUES
--(200, 'Mike', 'Da', 'mike.da@example.com', GETDATE(),GETDATE())

INSERT INTO Customers (customer_id, first_name, last_name, email, created_at,updated_at) VALUES
  (300, 'Robert', 'Miller', 'robert.miller@example.com', GETDATE(),GETDATE())

INSERT INTO Customers (customer_id, first_name, last_name, email, created_at,updated_at) VALUES
  (400, 'Santa', 'Clara', 'santa.clara@example.com', GETDATE(),GETDATE())
	
	
SELECT * FROM Customers;

DROP TABLE Products;

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    description TEXT,
    price DECIMAL(10, 2),
    stock_quantity INT,
    category_id INT,
    created_at DATETIME,
    updated_at DATETIME,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);




CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    description VARCHAR(255),
    price DECIMAL(10, 2),
    stock_quantity INT,
    category_id INT,
    created_at DATETIME,
    updated_at DATETIME,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

---- Insert records into the Products table
--INSERT INTO Products (product_id, product_name, description, price, stock_quantity, category_id, created_at, updated_at) VALUES
--  (1, 'Product A', 'Description of Product A', 49.99, 100, 1, GETDATE(), GETDATE())

--INSERT INTO Products (product_id, product_name, description, price, stock_quantity, category_id, created_at, updated_at) VALUES
-- (2, 'Product B', 'Description of Product B', 29.99, 75, 2, GETDATE(), GETDATE())

 INSERT INTO Products (product_id, product_name, description, price, stock_quantity, category_id, created_at, updated_at)
VALUES
    (3, 'Product C', 'Description of Product C', 39.99, 50, 6, GETDATE(), GETDATE())

INSERT INTO Products (product_id, product_name, description, price, stock_quantity, category_id, created_at, updated_at)
 VALUES
    (4, 'Product N', 'Description of Product 4', 19.99, 200, 7, GETDATE(), GETDATE());

SELECT * FROM Products;

DROP TABLE Orders;

-- Create the Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME,
    total_amount DECIMAL(10, 2),
    order_status NVARCHAR(50),
    shipping_address NVARCHAR(255),
	created_at DATETIME,
    updated_at DATETIME,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

--	-- Insert records into the Orders table
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, order_status, shipping_address, created_at, updated_at) VALUES
--  (7, 100, GETDATE(), 99.99, 'Processing', '123 Main St, City, Country', GETDATE(), GETDATE()),
--  (8, 200, GETDATE(), 149.99, 'Shipped', '456 Elm St, Town, Country', GETDATE(), GETDATE())

    (9, 300, GETDATE(), 199.99, 'Delivered', '789 Oak St, Village, Country', GETDATE(), GETDATE()),
	(4, 100, GETDATE(), 99.99, 'Processing', '123 Main St, City, Country', GETDATE(), GETDATE()),
    (5, 200, GETDATE(), 149.99, 'Shipped', '456 Elm St, Town, Country', GETDATE(), GETDATE()),
    (6, 300, GETDATE(), 199.99, 'Delivered', '789 Oak St, Village, Country', GETDATE(), GETDATE())

SELECT * FROM Orders;

DROP TABLE OrderItems;

-- Create the Order Items table
CREATE TABLE OrderItems (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    subtotal DECIMAL(10, 2),
	created_at DATETIME,
    updated_at DATETIME,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert records into the OrderItems table
INSERT INTO OrderItems (order_item_id, order_id, product_id, quantity, subtotal, created_at, updated_at)
VALUES
    --(1, 7, 1, 2, 99.98, GETDATE(), GETDATE()),
    --(2, 8, 2, 1, 29.99, GETDATE(), GETDATE())

    (3, 4, 3, 3, 149.97, GETDATE(), GETDATE()),
	(4, 5, 1, 2, 99.98, GETDATE(), GETDATE()),
    (5, 6, 2, 1, 29.99, GETDATE(), GETDATE()),
    (6, 9, 3, 3, 149.97, GETDATE(), GETDATE())

SELECT * FROM OrderItems;

DROP TABLE Reviews;

-- Create the Reviews table
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    rating INT,
    review_text NVARCHAR(255),
    review_date DATETIME,
	created_at DATETIME,
    updated_at DATETIME,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);


-- Insert records into the Reviews table
INSERT INTO Reviews (review_id, product_id, customer_id, rating, review_text, review_date, created_at, updated_at)
VALUES
   --(1, 1, 100, 5, 'This product is excellent!', GETDATE(), GETDATE(), GETDATE()),
   --(2, 2, 200, 4, 'Good product overall.', GETDATE(), GETDATE(), GETDATE())

    (3, 1, 300, 5, 'Highly recommended.', GETDATE(), GETDATE(), GETDATE()),
	(4, 3, 400, 3, 'Poor Product.', GETDATE(), GETDATE(), GETDATE())

SELECT * FROM Reviews;

-- Create the Cart table
CREATE TABLE Cart (
    cart_id INT PRIMARY KEY,
    customer_id INT,
	created_at DATETIME,
    updated_at DATETIME,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Insert records into the Cart table
INSERT INTO Cart (cart_id, customer_id, created_at, updated_at)
VALUES
  --(1, 100, GETDATE(), GETDATE()),
  --(2, 200, GETDATE(), GETDATE())

    (3, 300, GETDATE(), GETDATE()),
	(4, 400, GETDATE(), GETDATE())

SELECT * FROM Cart;

DROP TABLE Cart;


DROP TABLE CartItems;

-- Create the Cart Items table
CREATE TABLE CartItems (
    cart_item_id INT PRIMARY KEY,
    cart_id INT,
    product_id INT,
    quantity INT,
	created_at DATETIME,
    updated_at DATETIME,
    FOREIGN KEY (cart_id) REFERENCES Cart(cart_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
   -- Insert records into the CartItems table
INSERT INTO CartItems (cart_item_id, cart_id, product_id, quantity, created_at, updated_at)
VALUES
  --(1, 1, 1, 2, getdate(), getdate()),
  --(2, 1, 2, 1, getdate(), getdate())

    (3, 2, 3, 3, getdate(), getdate()),
	(4, 4, 4, 2, getdate(), getdate())

SELECT * FROM CartItems;
