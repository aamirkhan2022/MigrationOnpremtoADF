
DROP TABLE CATEGORIES;

CREATE TABLE CATEGORIES (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255),
	created_at DATETIME,
    updated_at DATETIME
);

SELECT * FROM CATEGORIES;

============================================================================

DROP TABLE CUSTOMERS;

CREATE TABLE CUSTOMERS (
   customer_id INT PRIMARY KEY,
    first_name NVARCHAR(255),
    last_name NVARCHAR(255),
    email NVARCHAR(255) UNIQUE,    
    created_at DATETIME,
    updated_at DATETIME
);

SELECT * FROM CUSTOMERS;
=============================================================================

DROP TABLE PRODUCTS;

CREATE TABLE PRODUCTS (
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

=======================================================================================================================

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


SELECT * FROM PRODUCTS;

==============================================================================

DROP TABLE ORDERS;

-- Create the Orders table
CREATE TABLE ORDERS (
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

SELECT * FROM ORDERS;

=======================================================================================

DROP TABLE ORDERITEMS;

-- Create the Order Items table
CREATE TABLE ORDERITEMS (
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

SELECT * FROM ORDERITEMS;

=====================================================================================

DROP TABLE REVIEWS;

-- Create the Reviews table
CREATE TABLE REVIEWS (
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

SELECT * FROM REVIEWS;

===============================================================================

DROP TABLE CART;

-- Create the Cart table
CREATE TABLE CART (
    cart_id INT PRIMARY KEY,
    customer_id INT,
	created_at DATETIME,
    updated_at DATETIME,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

SELECT * FROM CART;

================================================================

DROP TABLE CARTITEMS;

-- Create the Cart Items table
CREATE TABLE CARTITEMS (
    cart_item_id INT PRIMARY KEY,
    cart_id INT,
    product_id INT,
    quantity INT,
	created_at DATETIME,
    updated_at DATETIME,
    FOREIGN KEY (cart_id) REFERENCES Cart(cart_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


SELECT * FROM CARTITEMS;

=========================================================================================


-- STEP 5: CREATE A WATERMARK TABLE : TO TRACK TABLE NAMES, THEIR TIMESTAMPS FOR DATA CHANGES

create table watermarktable
(
   TableName varchar(255),
   WatermarkValue datetime			-- to track the old timestamp value @ ADF Pipelines
);

INSERT INTO watermarktable VALUES ('CATEGORIES', '1/1/2010 12:00:00 AM');

INSERT INTO watermarktable VALUES ('CUSTOMERS', '1/1/2010 12:00:00 AM')

INSERT INTO watermarktable VALUES ('PRODUCTS', '1/1/2010 12:00:00 AM')

INSERT INTO watermarktable VALUES ('ORDERS', '1/1/2010 12:00:00 AM')

INSERT INTO watermarktable VALUES ('ORDERITEMS', '1/1/2010 12:00:00 AM')

INSERT INTO watermarktable VALUES ('CART', '1/1/2010 12:00:00 AM')

INSERT INTO watermarktable VALUES ('CARTITEMS', '1/1/2010 12:00:00 AM')

INSERT INTO watermarktable VALUES ('REVIEWS', '1/1/2010 12:00:00 AM')

SELECT * FROM watermarktable;


-- Create the Store Procedure to setup the Old and New Watermark
CREATE PROCEDURE usp_write_watermark ( @LastModifiedtime datetime, @TableName sysname )
AS
BEGIN
  UPDATE watermarktable
   SET WatermarkValue = @LastModifiedtime WHERE TableName = @TableName
END;


SELECT watermarkvalue FROM watermarktable
WHERE TableName ='CATEGORIES';  -- OldWM Table
