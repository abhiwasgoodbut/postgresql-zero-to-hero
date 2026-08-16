-- ==========================================================
-- 🛒 Simple & Modern E-Commerce Database (ecom_db)
-- Designed for beginners: Clear names, realistic data, easy relationships!
-- ==========================================================

-- 1. Reset Database & Create Tables
DROP TABLE IF EXISTS reviews CASCADE;
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- ---------------------------------------------------------
-- TABLE 1: users (Customers)
-- ---------------------------------------------------------
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    city VARCHAR(100) NOT NULL,
    age INT CHECK (age >= 13),
    is_premium BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ---------------------------------------------------------
-- TABLE 2: categories (Product Categories)
-- ---------------------------------------------------------
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) UNIQUE NOT NULL
);

-- ---------------------------------------------------------
-- TABLE 3: products (Items for sale)
-- ---------------------------------------------------------
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    category_id INT REFERENCES categories(id) ON DELETE SET NULL,
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0),
    stock INT NOT NULL DEFAULT 0 CHECK (stock >= 0),
    brand VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ---------------------------------------------------------
-- TABLE 4: orders (Customer Orders)
-- ---------------------------------------------------------
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    status VARCHAR(50) DEFAULT 'delivered' CHECK (status IN ('pending', 'shipped', 'delivered', 'cancelled')),
    total_amount NUMERIC(10, 2) NOT NULL DEFAULT 0,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ---------------------------------------------------------
-- TABLE 5: order_items (Products in each order)
-- ---------------------------------------------------------
CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(id) ON DELETE CASCADE,
    product_id INT REFERENCES products(id) ON DELETE CASCADE,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10, 2) NOT NULL
);

-- ---------------------------------------------------------
-- TABLE 6: reviews (Product Reviews by Users)
-- ---------------------------------------------------------
CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    product_id INT REFERENCES products(id) ON DELETE CASCADE,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, product_id)
);


-- ==========================================================
-- 📦 SEED DATA (Realistic, modern, fun to query!)
-- ==========================================================

-- Insert Users
INSERT INTO users (name, email, city, age, is_premium) VALUES
('Alex Rivera', 'alex@gmail.com', 'New York', 24, TRUE),
('Priya Sharma', 'priya@outlook.com', 'Mumbai', 28, TRUE),
('John Doe', 'john@yahoo.com', 'London', 35, FALSE),
('Sara Connor', 'sara@gmail.com', 'Los Angeles', 29, TRUE),
('David Kim', 'david@gmail.com', 'Seoul', 22, FALSE),
('Emma Watson', 'emma@icloud.com', 'London', 31, FALSE),
('Rahul Verma', 'rahul@gmail.com', 'Bengaluru', 26, TRUE),
('Maria Garcia', 'maria@hotmail.com', 'Madrid', 40, FALSE),
('Liam Smith', 'liam@gmail.com', 'Sydney', 19, FALSE),
('Olivia Taylor', 'olivia@gmail.com', 'Toronto', 27, TRUE);

-- Insert Categories
INSERT INTO categories (name, slug) VALUES
('Smartphones & Tech', 'smartphones-tech'),
('Laptops & Computers', 'laptops-computers'),
('Audio & Headphones', 'audio-headphones'),
('Gaming', 'gaming'),
('Wearables & Fitness', 'wearables-fitness');

-- Insert Products
INSERT INTO products (title, category_id, price, stock, brand) VALUES
('iPhone 15 Pro', 1, 999.00, 45, 'Apple'),
('Samsung Galaxy S24 Ultra', 1, 1199.00, 30, 'Samsung'),
('Google Pixel 8', 1, 699.00, 50, 'Google'),
('MacBook Air M3', 2, 1099.00, 25, 'Apple'),
('Dell XPS 15', 2, 1499.00, 15, 'Dell'),
('Sony WH-1000XM5 Headphones', 3, 399.00, 60, 'Sony'),
('AirPods Pro 2', 3, 249.00, 100, 'Apple'),
('PlayStation 5 Console', 4, 499.00, 20, 'Sony'),
('Nintendo Switch OLED', 4, 349.00, 35, 'Nintendo'),
('Apple Watch Series 9', 5, 399.00, 40, 'Apple'),
('Logitech MX Master 3S Mouse', 2, 99.00, 120, 'Logitech'),
('Kindle Paperwhite', 1, 149.00, 80, 'Amazon');

-- Insert Orders
INSERT INTO orders (user_id, status, total_amount, order_date) VALUES
(1, 'delivered', 1248.00, '2026-07-01 10:30:00'),
(2, 'delivered', 1099.00, '2026-07-03 14:15:00'),
(3, 'delivered', 349.00,  '2026-07-05 09:00:00'),
(4, 'shipped',   1498.00, '2026-07-10 18:20:00'),
(1, 'delivered', 249.00,  '2026-07-12 11:45:00'),
(5, 'pending',   499.00,  '2026-07-15 16:10:00'),
(7, 'delivered', 1398.00, '2026-07-18 12:00:00'),
(8, 'cancelled', 99.00,   '2026-07-20 08:30:00'),
(10, 'delivered', 1598.00, '2026-07-22 19:40:00');

-- Insert Order Items
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
-- Order 1 (Alex): iPhone 15 Pro (999) + AirPods Pro 2 (249) = 1248
(1, 1, 1, 999.00),
(1, 7, 1, 249.00),
-- Order 2 (Priya): MacBook Air M3 (1099)
(2, 4, 1, 1099.00),
-- Order 3 (John): Nintendo Switch (349)
(3, 9, 1, 349.00),
-- Order 4 (Sara): iPhone 15 Pro (999) + PS5 (499) = 1498
(4, 1, 1, 999.00),
(4, 8, 1, 499.00),
-- Order 5 (Alex): AirPods Pro 2 (249)
(5, 7, 1, 249.00),
-- Order 6 (David): PS5 (499)
(6, 8, 1, 499.00),
-- Order 7 (Rahul): Galaxy S24 Ultra (1199) + Logitech Mouse (99) + AirPods (100 error fixed)
(7, 2, 1, 1199.00),
(7, 11, 2, 99.00),
-- Order 8 (Maria): Logitech Mouse (99)
(8, 11, 1, 99.00),
-- Order 9 (Olivia): MacBook Air M3 (1099) + PS5 (499) = 1598
(9, 4, 1, 1099.00),
(9, 8, 1, 499.00);

-- Insert Reviews
INSERT INTO reviews (user_id, product_id, rating, comment) VALUES
(1, 1, 5, 'Best phone ever, titanium build feels super premium!'),
(4, 1, 5, 'Upgraded from iPhone 11, massive camera improvement.'),
(2, 4, 5, 'Battery lasts 2 full days, perfect for coding and work.'),
(1, 7, 4, 'Great noise cancellation, fits well in ear.'),
(3, 9, 4, 'Fun console for casual couch gaming with family.'),
(7, 2, 5, 'The zoom camera on S24 Ultra is unbelievable!'),
(5, 8, 5, 'Fast load times and beautiful 4k 60fps gaming.'),
(7, 11, 4, 'Very comfortable ergonomic mouse for long work hours.'),
(10, 8, 5, 'Spider-man and God of War look mind-blowing on PS5.');
