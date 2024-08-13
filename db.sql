DROP DATABASE IF EXISTS eShop;
CREATE DATABASE eShop;
USE eShop;

CREATE TABLE users (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(10) CHECK (role IN ('admin', 'user')) NOT NULL,
    status ENUM('Active', 'Inactive') NOT NULL DEFAULT 'Active'
);




CREATE TABLE category (
	category_id INT AUTO_INCREMENT PRIMARY KEY,
     	name VARCHAR(255) NOT NULL
     );




CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    category_id INT,
    status ENUM('active', 'inactive') DEFAULT 'active',
    image VARCHAR(255), -- Added column for image URL or path
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);


CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);


CREATE TABLE ordered_products (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- Insert a user into the users table
INSERT INTO users (name, email, password, role, status) 
VALUES ('John', 'admin@eShop.com', '123456', 'admin', 'Active');

-- Insert categories into the category table
INSERT INTO category (name) VALUES ('Hand Tools');
INSERT INTO category (name) VALUES ('Power Tools');
INSERT INTO category (name) VALUES ('Safety Equipment');

-- Insert products into the product table
INSERT INTO product (name, description, price, stock_quantity, category_id, status)
VALUES ('Hammer', 'A durable and strong hammer for general use.', 12.99, 50, 1, 'active');
INSERT INTO product (name, description, price, stock_quantity, category_id, status)
VALUES ('Screwdriver Set', 'A set of flat-head and Phillips screwdrivers.', 19.99, 30, 1, 'active');
INSERT INTO product (name, description, price, stock_quantity, category_id, status)
VALUES ('Pliers', 'High-quality pliers with a comfortable grip.', 15.49, 40, 1, 'active');
INSERT INTO product (name, description, price, stock_quantity, category_id, status)
VALUES ('Adjustable Wrench', 'A versatile wrench for various sizes of nuts and bolts.', 17.89, 35, 1, 'active');
INSERT INTO product (name, description, price, stock_quantity, category_id, status)
VALUES ('Utility Knife', 'A sharp and precise utility knife for cutting.', 9.99, 60, 1, 'active');
INSERT INTO product (name, description, price, stock_quantity, category_id, status)
VALUES ('Cordless Drill', 'A powerful cordless drill for drilling and driving.', 79.99, 25, 2, 'active');
INSERT INTO product (name, description, price, stock_quantity, category_id, status)
VALUES ('Circular Saw', 'A reliable circular saw for cutting wood and metal.', 99.99, 20, 2, 'active');
INSERT INTO product (name, description, price, stock_quantity, category_id, status)
VALUES ('Jigsaw', 'A precise jigsaw for cutting curves and intricate shapes.', 89.99, 15, 2, 'active');
INSERT INTO product (name, description, price, stock_quantity, category_id, status)
VALUES ('Angle Grinder', 'A powerful angle grinder for cutting, grinding, and polishing.', 69.99, 10, 2, 'active');
INSERT INTO product (name, description, price, stock_quantity, category_id, status)
VALUES ('Sander', 'An electric sander for smoothing surfaces.', 54.99, 18, 2, 'active');
INSERT INTO product (name, description, price, stock_quantity, category_id, status)
VALUES ('Safety Glasses', 'Protective safety glasses for eye protection.', 8.99, 100, 3, 'active');
INSERT INTO product (name, description, price, stock_quantity, category_id, status)
VALUES ('Work Gloves', 'Durable work gloves for hand protection.', 14.99, 80, 3, 'active');
INSERT INTO product (name, description, price, stock_quantity, category_id, status)
VALUES ('Ear Protection', 'Earmuffs for noise reduction and ear protection.', 12.49, 60, 3, 'active');
INSERT INTO product (name, description, price, stock_quantity, category_id, status)
VALUES ('Dust Mask', 'Dust masks to prevent inhalation of dust and fumes.', 5.99, 120, 3, 'active');
INSERT INTO product (name, description, price, stock_quantity, category_id, status)
VALUES ('Hard Hat', 'A hard hat for head protection in construction areas.', 24.99, 40, 3, 'active');
INSERT INTO product (name, description, price, stock_quantity, category_id, status)
VALUES ('Tape Measure', 'A retractable tape measure for accurate measurements.', 7.99, 70, 1, 'active');
INSERT INTO product (name, description, price, stock_quantity, category_id, status)
VALUES ('Chisel Set', 'A set of chisels for carving and cutting.', 29.99, 25, 1, 'active');
INSERT INTO product (name, description, price, stock_quantity, category_id, status)
VALUES ('Ladder', 'A sturdy ladder for reaching high areas.', 49.99, 15, 1, 'active');
INSERT INTO product (name, description, price, stock_quantity, category_id, status)
VALUES ('Paint Roller', 'A roller for applying paint smoothly.', 9.49, 50, 1, 'active');
INSERT INTO product (name, description, price, stock_quantity, category_id, status)
VALUES ('Toolbox', 'A large toolbox for organizing and carrying tools.', 39.99, 30, 1, 'active');
