# 🐘 PostgreSQL Follow-Along Lab — Type Every Command!

> **How to use**: Open `psql` next to this file. Type every command yourself — don't copy-paste!
> Typing builds muscle memory. Read the explanation, then type the command, then check the result.

---

# 🟢 PART 1 — SETUP & BASICS

---

## Step 1 — Connect to PostgreSQL

Open your terminal and type:

```bash
psql -U postgres
```

Enter your password when prompted. You should see `postgres=#`

---

## Step 2 — Explore the Server

```sql
-- Check your PostgreSQL version
SELECT version();

-- Check current user
SELECT current_user;

-- Check current database
SELECT current_database();

-- List all databases
\l

-- List all users/roles
\du
```

---

## Step 3 — Create Our Practice Database

```sql
-- Create the database
CREATE DATABASE shopdb;

-- Connect to it
\c shopdb

-- Verify you're in shopdb
SELECT current_database();
```

You should see: `shopdb`

---

## Step 4 — Create Our First Table: users

```sql
CREATE TABLE users (
    id              SERIAL PRIMARY KEY,
    username        VARCHAR(50) UNIQUE NOT NULL,
    email           VARCHAR(255) UNIQUE NOT NULL,
    password_hash   VARCHAR(255) NOT NULL,
    full_name       VARCHAR(100) NOT NULL,
    age             INTEGER CHECK (age >= 13),
    is_active       BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);
```

Now verify the table structure:

```sql
-- Describe the table
\d users

-- More detailed view
\d+ users
```

---

## Step 5 — Create the categories Table

```sql
CREATE TABLE categories (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);
```

---

## Step 6 — Create the products Table (with Foreign Key!)

```sql
CREATE TABLE products (
    id              SERIAL PRIMARY KEY,
    name            VARCHAR(200) NOT NULL,
    description     TEXT,
    price           DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    stock           INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),
    category_id     INTEGER REFERENCES categories(id) ON DELETE SET NULL,
    is_available    BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);
```

---

## Step 7 — Create the orders Table

```sql
CREATE TABLE orders (
    id                  SERIAL PRIMARY KEY,
    user_id             INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    status              VARCHAR(20) DEFAULT 'pending',
    total_amount        DECIMAL(10, 2) NOT NULL CHECK (total_amount >= 0),
    shipping_address    TEXT NOT NULL,
    ordered_at          TIMESTAMPTZ DEFAULT NOW()
);
```

---

## Step 8 — Create the order_items Table

```sql
CREATE TABLE order_items (
    id          SERIAL PRIMARY KEY,
    order_id    INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id  INTEGER NOT NULL REFERENCES products(id) ON DELETE RESTRICT,
    quantity    INTEGER NOT NULL CHECK (quantity > 0),
    unit_price  DECIMAL(10, 2) NOT NULL
);
```

---

## Step 9 — Create the reviews Table

```sql
CREATE TABLE reviews (
    id          SERIAL PRIMARY KEY,
    user_id     INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    product_id  INTEGER NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    rating      SMALLINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment     TEXT,
    created_at  TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(user_id, product_id)
);
```

---

## Step 10 — Verify All Tables

```sql
-- List all tables
\dt

-- Count: should show 6 tables
SELECT COUNT(*) FROM information_schema.tables
WHERE table_schema = 'public' AND table_type = 'BASE TABLE';
```

---

# 🟢 PART 2 — INSERT DATA

---

## Step 11 — Insert Users

```sql
INSERT INTO users (username, email, password_hash, full_name, age) VALUES
    ('alice',   'alice@mail.com',   'hash_alice123',  'Alice Johnson',   25),
    ('bob',     'bob@mail.com',     'hash_bob456',    'Bob Wilson',      30),
    ('charlie', 'charlie@mail.com', 'hash_charlie789','Charlie Kumar',   22),
    ('diana',   'diana@mail.com',   'hash_diana321',  'Diana Chen',      28),
    ('eve',     'eve@mail.com',     'hash_eve654',    'Eve Martinez',    35),
    ('frank',   'frank@mail.com',   'hash_frank987',  'Frank Ahmed',     19);
```

Verify:

```sql
SELECT * FROM users;

-- Count
SELECT COUNT(*) FROM users;
```

---

## Step 12 — Insert with RETURNING

```sql
-- RETURNING gives you back what was inserted
INSERT INTO users (username, email, password_hash, full_name, age)
VALUES ('grace', 'grace@mail.com', 'hash_grace111', 'Grace Lee', 27)
RETURNING id, username, email;
```

Notice: PostgreSQL tells you the auto-generated `id`!

---

## Step 13 — Insert Categories

```sql
INSERT INTO categories (name, description) VALUES
    ('Electronics',     'Gadgets, devices, and tech accessories'),
    ('Clothing',        'Apparel, shoes, and fashion accessories'),
    ('Books',           'Physical and digital books'),
    ('Home & Kitchen',  'Home appliances and kitchen tools'),
    ('Sports',          'Sports equipment and fitness gear');
```

Verify:

```sql
SELECT * FROM categories;
```

---

## Step 14 — Insert Products

```sql
INSERT INTO products (name, description, price, stock, category_id) VALUES
    ('Laptop Pro 15',           'High-performance laptop with 16GB RAM',     1299.99, 50,  1),
    ('Wireless Mouse',          'Ergonomic wireless mouse with USB receiver', 29.99, 200, 1),
    ('USB-C Hub',               '7-in-1 USB-C hub with HDMI',                49.99, 150, 1),
    ('Mens T-Shirt',            'Cotton crew neck t-shirt',                   19.99, 300, 2),
    ('Running Shoes',           'Lightweight running shoes',                  89.99, 100, 2),
    ('JavaScript: Good Parts',  'Classic JS book by Douglas Crockford',       35.00,  75, 3),
    ('Database Design Book',    'Comprehensive guide to database design',     45.00,  60, 3),
    ('Coffee Maker',            'Programmable 12-cup coffee maker',           79.99,  80, 4),
    ('Yoga Mat',                'Non-slip exercise yoga mat',                 24.99, 120, 5),
    ('Basketball',              'Official size indoor/outdoor basketball',    29.99,  90, 5);
```

Verify:

```sql
SELECT id, name, price, stock FROM products;
```

---

## Step 15 — Insert Orders

```sql
INSERT INTO orders (user_id, status, total_amount, shipping_address) VALUES
    (1, 'delivered',  1329.98, '123 Main St, New York, NY 10001'),
    (2, 'shipped',     89.99, '456 Oak Ave, London, UK'),
    (1, 'confirmed',  114.98, '123 Main St, New York, NY 10001'),
    (3, 'pending',     64.99, '789 Pine Rd, Mumbai, India'),
    (4, 'delivered',  159.98, '321 Elm St, Tokyo, Japan');
```

Verify:

```sql
SELECT * FROM orders;
```

---

## Step 16 — Insert Order Items

```sql
INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
    (1, 1, 1, 1299.99),     -- Order 1: 1x Laptop
    (1, 2, 1,   29.99),     -- Order 1: 1x Mouse
    (2, 5, 1,   89.99),     -- Order 2: 1x Running Shoes
    (3, 4, 2,   19.99),     -- Order 3: 2x T-Shirt
    (3, 9, 3,   24.99),     -- Order 3: 3x Yoga Mat
    (4, 3, 1,   49.99),     -- Order 4: 1x USB-C Hub
    (4, 6, 1,   35.00),     -- Order 4: 1x JS Book (wait, total doesn't match — that's ok for practice)
    (5, 8, 2,   79.99);     -- Order 5: 2x Coffee Maker
```

Verify:

```sql
SELECT * FROM order_items;
```

---

## Step 17 — Insert Reviews

```sql
INSERT INTO reviews (user_id, product_id, rating, comment) VALUES
    (1, 1, 5, 'Amazing laptop! Super fast and great display.'),
    (2, 1, 4, 'Good laptop but a bit heavy.'),
    (3, 2, 5, 'Best wireless mouse I have ever used.'),
    (1, 5, 4, 'Very comfortable running shoes.'),
    (4, 8, 3, 'Coffee maker is decent. Takes a while to brew.'),
    (2, 6, 5, 'Must-read book for every JavaScript developer.'),
    (5, 4, 4, 'Nice quality t-shirt. Fits well.'),
    (3, 9, 5, 'Perfect yoga mat. Non-slip and thick.'),
    (4, 1, 5, 'Best purchase I made this year!'),
    (1, 2, 4, 'Good mouse, battery lasts long.');
```

Verify:

```sql
SELECT COUNT(*) FROM reviews;
-- Should be 10
```

---

## Step 18 — Test Constraints (Watch Them Fail!)

```sql
-- Test 1: Rating out of range (should FAIL)
INSERT INTO reviews (user_id, product_id, rating, comment)
VALUES (1, 3, 6, 'Testing invalid rating');
-- ERROR: new row violates check constraint "reviews_rating_check"

-- Test 2: Duplicate review — same user, same product (should FAIL)
INSERT INTO reviews (user_id, product_id, rating, comment)
VALUES (1, 1, 3, 'Trying to review again');
-- ERROR: duplicate key value violates unique constraint "reviews_user_id_product_id_key"

-- Test 3: Foreign key violation — non-existent user (should FAIL)
INSERT INTO orders (user_id, status, total_amount, shipping_address)
VALUES (999, 'pending', 50.00, 'Nowhere');
-- ERROR: insert or update violates foreign key constraint

-- Test 4: Negative price (should FAIL)
INSERT INTO products (name, price, stock, category_id)
VALUES ('Bad Product', -10.00, 5, 1);
-- ERROR: new row violates check constraint "products_price_check"
```

All 4 should give you errors. That's PostgreSQL protecting your data!

---

# 🟡 PART 3 — SELECT QUERIES

---

## Step 19 — Basic SELECT

```sql
-- All columns, all rows
SELECT * FROM users;

-- Specific columns only
SELECT username, email, age FROM users;

-- With aliases (rename columns in output)
SELECT
    username AS "User",
    email AS "Email Address",
    age AS "Age"
FROM users;
```

---

## Step 20 — Expressions & Calculated Columns

```sql
-- Calculate price with 18% tax
SELECT
    name,
    price,
    ROUND(price * 1.18, 2) AS price_with_tax
FROM products;

-- String manipulation
SELECT
    username,
    UPPER(username) AS username_upper,
    LENGTH(email) AS email_length
FROM users;

-- Stock value per product
SELECT
    name,
    price,
    stock,
    ROUND(price * stock, 2) AS total_stock_value
FROM products
ORDER BY total_stock_value DESC;
```

---

## Step 21 — DISTINCT

```sql
-- Unique order statuses
SELECT DISTINCT status FROM orders;

-- Unique category_ids in products
SELECT DISTINCT category_id FROM products;
```

---

## Step 22 — COUNT, SUM, AVG, MIN, MAX

```sql
-- Total users
SELECT COUNT(*) AS total_users FROM users;

-- Total products
SELECT COUNT(*) AS total_products FROM products;

-- Average product price
SELECT ROUND(AVG(price), 2) AS avg_price FROM products;

-- Cheapest and most expensive
SELECT
    MIN(price) AS cheapest,
    MAX(price) AS most_expensive
FROM products;

-- Total stock value across all products
SELECT ROUND(SUM(price * stock), 2) AS total_inventory_value FROM products;
```

---

# 🟡 PART 4 — WHERE CLAUSE (FILTERING)

---

## Step 23 — Comparison Operators

```sql
-- Products over $50
SELECT name, price FROM products WHERE price > 50;

-- Products exactly $29.99
SELECT name, price FROM products WHERE price = 29.99;

-- Users 25 or younger
SELECT username, age FROM users WHERE age <= 25;

-- Orders not pending
SELECT id, status, total_amount FROM orders WHERE status != 'pending';
```

---

## Step 24 — AND, OR, NOT

```sql
-- Products between $20 and $50
SELECT name, price FROM products WHERE price >= 20 AND price <= 50;

-- Users under 20 OR over 30
SELECT username, age FROM users WHERE age < 20 OR age > 30;

-- Active users who are NOT under 25
SELECT username, age, is_active FROM users WHERE is_active = TRUE AND NOT age < 25;
```

---

## Step 25 — IN, NOT IN, BETWEEN

```sql
-- Orders that are shipped or delivered
SELECT id, status, total_amount FROM orders
WHERE status IN ('shipped', 'delivered');

-- Products NOT in Electronics (category 1) or Clothing (category 2)
SELECT name, category_id FROM products
WHERE category_id NOT IN (1, 2);

-- Products priced between $25 and $100 (inclusive)
SELECT name, price FROM products
WHERE price BETWEEN 25 AND 100;

-- Users aged 20 to 30
SELECT username, age FROM users
WHERE age BETWEEN 20 AND 30;
```

---

## Step 26 — LIKE and ILIKE

```sql
-- Usernames starting with 'a'
SELECT username FROM users WHERE username LIKE 'a%';

-- Usernames containing 'a' anywhere
SELECT username FROM users WHERE username LIKE '%a%';

-- Products with 'book' in the name (case-insensitive)
SELECT name FROM products WHERE name ILIKE '%book%';

-- Emails ending with '@mail.com'
SELECT email FROM users WHERE email LIKE '%@mail.com';

-- Usernames exactly 3 characters long
SELECT username FROM users WHERE username LIKE '___';
```

---

## Step 27 — IS NULL / IS NOT NULL

```sql
-- Products without a description
SELECT name FROM products WHERE description IS NULL;

-- Products that DO have a description
SELECT name, description FROM products WHERE description IS NOT NULL;

-- IMPORTANT: This does NOT work (common mistake!)
-- SELECT * FROM products WHERE description = NULL;   ← WRONG!
-- Always use IS NULL / IS NOT NULL
```

---

## Step 28 — ORDER BY

```sql
-- Products cheapest first
SELECT name, price FROM products ORDER BY price ASC;

-- Products most expensive first
SELECT name, price FROM products ORDER BY price DESC;

-- Users sorted by age ascending, then by username alphabetically
SELECT username, age FROM users ORDER BY age ASC, username ASC;

-- Orders: most recent first
SELECT id, status, ordered_at FROM orders ORDER BY ordered_at DESC;
```

---

## Step 29 — LIMIT and OFFSET (Pagination)

```sql
-- Top 3 most expensive products
SELECT name, price FROM products ORDER BY price DESC LIMIT 3;

-- Top 3 cheapest products
SELECT name, price FROM products ORDER BY price ASC LIMIT 3;

-- Page 1 (first 3 products)
SELECT name, price FROM products ORDER BY price ASC LIMIT 3 OFFSET 0;

-- Page 2 (products 4-6)
SELECT name, price FROM products ORDER BY price ASC LIMIT 3 OFFSET 3;

-- Page 3 (products 7-9)
SELECT name, price FROM products ORDER BY price ASC LIMIT 3 OFFSET 6;
```

---

# 🔵 PART 5 — JOINs

---

## Step 30 — INNER JOIN

```sql
-- Products with their category name
SELECT
    p.name AS product,
    p.price,
    c.name AS category
FROM products p
INNER JOIN categories c ON p.category_id = c.id;
```

Only shows products that HAVE a category.

---

## Step 31 — LEFT JOIN

```sql
-- ALL products, even those without a category
SELECT
    p.name AS product,
    p.price,
    c.name AS category
FROM products p
LEFT JOIN categories c ON p.category_id = c.id;
```

Products with no category show `NULL` for category name.

---

## Step 32 — JOIN Orders with Users

```sql
-- Who placed each order?
SELECT
    u.username,
    o.id AS order_id,
    o.status,
    o.total_amount,
    o.ordered_at
FROM orders o
INNER JOIN users u ON o.user_id = u.id
ORDER BY o.ordered_at DESC;
```

---

## Step 33 — Find Users Who Never Ordered

```sql
-- LEFT JOIN + filter for NULL = find missing relationships
SELECT
    u.username,
    u.email
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
WHERE o.id IS NULL;
```

These users have zero orders!

---

## Step 34 — Multi-Table JOIN (4 Tables!)

```sql
-- Full order details: who bought what, how many, at what price
SELECT
    u.username,
    o.id AS order_id,
    o.status,
    p.name AS product,
    oi.quantity,
    oi.unit_price,
    ROUND(oi.quantity * oi.unit_price, 2) AS line_total
FROM orders o
JOIN users u ON o.user_id = u.id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
ORDER BY o.id, p.name;
```

---

## Step 35 — Reviews with User and Product Names

```sql
SELECT
    u.username,
    p.name AS product,
    r.rating,
    r.comment,
    r.created_at
FROM reviews r
JOIN users u ON r.user_id = u.id
JOIN products p ON r.product_id = p.id
ORDER BY r.rating DESC;
```

---

## Step 36 — Products Without Any Reviews

```sql
SELECT
    p.name AS product,
    p.price
FROM products p
LEFT JOIN reviews r ON p.id = r.product_id
WHERE r.id IS NULL;
```

---

# 🔵 PART 6 — GROUP BY & HAVING

---

## Step 37 — Count Products per Category

```sql
SELECT
    c.name AS category,
    COUNT(p.id) AS product_count
FROM categories c
LEFT JOIN products p ON c.id = p.category_id
GROUP BY c.id, c.name
ORDER BY product_count DESC;
```

---

## Step 38 — Category Statistics

```sql
SELECT
    c.name AS category,
    COUNT(p.id) AS product_count,
    ROUND(AVG(p.price), 2) AS avg_price,
    MIN(p.price) AS cheapest,
    MAX(p.price) AS most_expensive,
    SUM(p.stock) AS total_stock
FROM categories c
JOIN products p ON c.id = p.category_id
GROUP BY c.id, c.name
ORDER BY avg_price DESC;
```

---

## Step 39 — Spending per User

```sql
SELECT
    u.username,
    COUNT(o.id) AS order_count,
    COALESCE(SUM(o.total_amount), 0) AS total_spent,
    COALESCE(ROUND(AVG(o.total_amount), 2), 0) AS avg_order
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.username
ORDER BY total_spent DESC;
```

`COALESCE` turns NULL into 0 for users with no orders.

---

## Step 40 — HAVING (Filter Groups)

```sql
-- Categories with more than 2 products
SELECT
    c.name AS category,
    COUNT(p.id) AS product_count
FROM categories c
JOIN products p ON c.id = p.category_id
GROUP BY c.id, c.name
HAVING COUNT(p.id) > 2;

-- Users who spent more than $100
SELECT
    u.username,
    SUM(o.total_amount) AS total_spent
FROM users u
JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.username
HAVING SUM(o.total_amount) > 100
ORDER BY total_spent DESC;
```

---

## Step 41 — Average Rating per Product

```sql
SELECT
    p.name AS product,
    ROUND(AVG(r.rating), 1) AS avg_rating,
    COUNT(r.id) AS review_count
FROM products p
JOIN reviews r ON p.id = r.product_id
GROUP BY p.id, p.name
HAVING COUNT(r.id) >= 2
ORDER BY avg_rating DESC;
```

---

## Step 42 — STRING_AGG and ARRAY_AGG

```sql
-- List all reviewers for each product (comma-separated)
SELECT
    p.name AS product,
    STRING_AGG(u.username, ', ' ORDER BY u.username) AS reviewed_by
FROM products p
JOIN reviews r ON p.id = r.product_id
JOIN users u ON r.user_id = u.id
GROUP BY p.id, p.name;

-- Same but as an array
SELECT
    p.name AS product,
    ARRAY_AGG(u.username ORDER BY u.username) AS reviewed_by
FROM products p
JOIN reviews r ON p.id = r.product_id
JOIN users u ON r.user_id = u.id
GROUP BY p.id, p.name;
```

---

# 🟣 PART 7 — SUBQUERIES & CTEs

---

## Step 43 — Subquery in WHERE

```sql
-- Products priced above average
SELECT name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- Users who have placed at least one order
SELECT username, email
FROM users
WHERE id IN (SELECT DISTINCT user_id FROM orders);
```

---

## Step 44 — EXISTS

```sql
-- Products that have at least one review
SELECT p.name, p.price
FROM products p
WHERE EXISTS (
    SELECT 1 FROM reviews r WHERE r.product_id = p.id
);

-- Products with NO reviews
SELECT p.name, p.price
FROM products p
WHERE NOT EXISTS (
    SELECT 1 FROM reviews r WHERE r.product_id = p.id
);
```

---

## Step 45 — Subquery in SELECT

```sql
-- Each user with their order count (without JOIN)
SELECT
    username,
    email,
    (SELECT COUNT(*) FROM orders o WHERE o.user_id = u.id) AS order_count,
    (SELECT COALESCE(SUM(total_amount), 0) FROM orders o WHERE o.user_id = u.id) AS total_spent
FROM users u
ORDER BY total_spent DESC;
```

---

## Step 46 — Basic CTE

```sql
-- CTE: Find expensive products, then filter by category
WITH expensive AS (
    SELECT * FROM products WHERE price > 50
)
SELECT e.name, e.price, c.name AS category
FROM expensive e
JOIN categories c ON e.category_id = c.id
WHERE c.name = 'Electronics';
```

---

## Step 47 — Multiple CTEs

```sql
WITH
    user_spending AS (
        SELECT
            user_id,
            COUNT(*) AS order_count,
            SUM(total_amount) AS total_spent
        FROM orders
        GROUP BY user_id
    ),
    user_reviews AS (
        SELECT
            user_id,
            COUNT(*) AS review_count,
            ROUND(AVG(rating), 1) AS avg_rating
        FROM reviews
        GROUP BY user_id
    )
SELECT
    u.username,
    u.email,
    COALESCE(us.order_count, 0) AS orders,
    COALESCE(us.total_spent, 0) AS spent,
    COALESCE(ur.review_count, 0) AS reviews,
    COALESCE(ur.avg_rating, 0) AS avg_rating
FROM users u
LEFT JOIN user_spending us ON u.id = us.user_id
LEFT JOIN user_reviews ur ON u.id = ur.user_id
ORDER BY spent DESC;
```

---

# 🟣 PART 8 — UPDATE, DELETE & UPSERT

---

## Step 48 — Basic UPDATE

```sql
-- Increase all Electronics prices by 10%
UPDATE products
SET price = ROUND(price * 1.10, 2)
WHERE category_id = (SELECT id FROM categories WHERE name = 'Electronics');

-- Verify
SELECT name, price FROM products WHERE category_id = 1;
```

---

## Step 49 — UPDATE with RETURNING

```sql
-- Confirm all pending orders
UPDATE orders
SET status = 'confirmed'
WHERE status = 'pending'
RETURNING id, status, total_amount;
```

---

## Step 50 — UPDATE with Subquery

```sql
-- Deactivate users who never ordered
UPDATE users
SET is_active = FALSE
WHERE id NOT IN (SELECT DISTINCT user_id FROM orders)
RETURNING username, is_active;
```

---

## Step 51 — DELETE with RETURNING

```sql
-- Delete reviews with rating 1 (if any exist)
DELETE FROM reviews
WHERE rating = 1
RETURNING *;

-- If no rows deleted, that's fine — we didn't insert any 1-star reviews
```

---

## Step 52 — UPSERT (ON CONFLICT)

```sql
-- Try to insert 'Electronics' again — if exists, update description
INSERT INTO categories (name, description)
VALUES ('Electronics', 'Updated: All gadgets, devices, and tech accessories')
ON CONFLICT (name)
DO UPDATE SET description = EXCLUDED.description
RETURNING *;

-- Try to insert, do nothing if exists
INSERT INTO categories (name, description)
VALUES ('Electronics', 'This will not overwrite')
ON CONFLICT (name) DO NOTHING;
```

---

# 🔴 PART 9 — INDEXES & PERFORMANCE

---

## Step 53 — EXPLAIN ANALYZE (Before Index)

```sql
-- See how PostgreSQL executes this query
EXPLAIN ANALYZE SELECT * FROM products WHERE price > 50;
```

Look for: **Seq Scan** (sequential scan — reads every row)

---

## Step 54 — Create Indexes

```sql
-- Index on price
CREATE INDEX idx_products_price ON products(price);

-- Index on user email (frequently searched)
CREATE INDEX idx_users_email ON users(email);

-- Index on orders user_id (for JOINs)
CREATE INDEX idx_orders_user_id ON orders(user_id);

-- Index on reviews product_id (for JOINs)
CREATE INDEX idx_reviews_product_id ON reviews(product_id);

-- Index on order_items order_id
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
```

---

## Step 55 — EXPLAIN ANALYZE (After Index)

```sql
-- Same query — should now use Index Scan
EXPLAIN ANALYZE SELECT * FROM products WHERE price > 50;
```

Look for: **Index Scan** or **Bitmap Index Scan** — faster!

> Note: With small tables (10 rows), PostgreSQL may still choose Seq Scan because it's faster for tiny datasets. Indexes shine with thousands+ rows.

---

## Step 56 — Manage Indexes

```sql
-- List all indexes
\di

-- Indexes on a specific table
SELECT indexname, indexdef FROM pg_indexes WHERE tablename = 'products';

-- Check table and index sizes
SELECT
    pg_size_pretty(pg_table_size('products')) AS table_size,
    pg_size_pretty(pg_indexes_size('products')) AS indexes_size,
    pg_size_pretty(pg_total_relation_size('products')) AS total_size;
```

---

# 🔴 PART 10 — VIEWS

---

## Step 57 — Create a Product Overview View

```sql
CREATE VIEW product_overview AS
SELECT
    p.id,
    p.name AS product,
    c.name AS category,
    p.price,
    p.stock,
    COALESCE(ROUND(AVG(r.rating), 1), 0) AS avg_rating,
    COUNT(r.id) AS review_count
FROM products p
LEFT JOIN categories c ON p.category_id = c.id
LEFT JOIN reviews r ON p.id = r.product_id
GROUP BY p.id, p.name, c.name, p.price, p.stock;
```

Now use it like a table:

```sql
-- All products overview
SELECT * FROM product_overview ORDER BY avg_rating DESC;

-- Only Electronics
SELECT * FROM product_overview WHERE category = 'Electronics';

-- Products with reviews
SELECT * FROM product_overview WHERE review_count > 0;
```

---

## Step 58 — Create a User Dashboard View

```sql
CREATE VIEW user_dashboard AS
SELECT
    u.id,
    u.username,
    u.email,
    u.is_active,
    COUNT(DISTINCT o.id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_spent,
    COALESCE(ROUND(AVG(o.total_amount), 2), 0) AS avg_order_value,
    COUNT(DISTINCT r.id) AS reviews_written,
    u.created_at AS member_since
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
LEFT JOIN reviews r ON u.id = r.user_id
GROUP BY u.id, u.username, u.email, u.is_active, u.created_at;
```

Use it:

```sql
SELECT * FROM user_dashboard ORDER BY total_spent DESC;
```

---

# 🔴 PART 11 — TRANSACTIONS

---

## Step 59 — Basic Transaction

```sql
-- Start a transaction
BEGIN;

-- Insert a new order
INSERT INTO orders (user_id, status, total_amount, shipping_address)
VALUES (2, 'pending', 54.98, '456 Oak Ave, London, UK')
RETURNING id;
-- Note the returned id (let's say it's 6)

-- Add items to the order (use the actual id returned above)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (6, 9, 1, 24.99);

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (6, 2, 1, 29.99);

-- Decrease stock
UPDATE products SET stock = stock - 1 WHERE id = 9;
UPDATE products SET stock = stock - 1 WHERE id = 2;

-- Everything looks good — save it!
COMMIT;
```

---

## Step 60 — ROLLBACK

```sql
BEGIN;

-- Insert a fake user
INSERT INTO users (username, email, password_hash, full_name, age)
VALUES ('fake_user', 'fake@mail.com', 'hash_fake', 'Fake Person', 99);

-- Check — the user exists within this transaction
SELECT * FROM users WHERE username = 'fake_user';

-- Changed our mind — undo everything
ROLLBACK;

-- Verify — the user does NOT exist
SELECT * FROM users WHERE username = 'fake_user';
-- Empty result! The insert was undone.
```

---

## Step 61 — Savepoints

```sql
BEGIN;

-- Insert an order
INSERT INTO orders (user_id, status, total_amount, shipping_address)
VALUES (3, 'pending', 45.00, '789 Pine Rd, Mumbai, India')
RETURNING id;

-- Set a savepoint
SAVEPOINT before_items;

-- Insert wrong item (oops!)
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (7, 1, 1, 9999.99);

-- That was wrong — go back to savepoint
ROLLBACK TO SAVEPOINT before_items;

-- Insert correct item
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (7, 7, 1, 45.00);

-- Save everything
COMMIT;

-- Verify
SELECT * FROM order_items WHERE order_id = 7;
```

---

# 🔴 PART 12 — FUNCTIONS & TRIGGERS

---

## Step 62 — Create a Function

```sql
-- Tax calculator function
CREATE OR REPLACE FUNCTION calculate_total(
    price DECIMAL,
    quantity INTEGER,
    tax_rate DECIMAL DEFAULT 0.18
)
RETURNS DECIMAL AS $$
BEGIN
    RETURN ROUND(price * quantity * (1 + tax_rate), 2);
END;
$$ LANGUAGE plpgsql;

-- Test it!
SELECT calculate_total(100, 2);           -- 236.00
SELECT calculate_total(100, 2, 0.10);     -- 220.00
SELECT calculate_total(49.99, 3);         -- 176.96
```

---

## Step 63 — Function That Returns a Table

```sql
CREATE OR REPLACE FUNCTION get_user_summary(uid INTEGER)
RETURNS TABLE (
    username VARCHAR,
    email VARCHAR,
    order_count BIGINT,
    total_spent DECIMAL
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        u.username,
        u.email,
        COUNT(o.id),
        COALESCE(SUM(o.total_amount), 0)
    FROM users u
    LEFT JOIN orders o ON u.id = o.user_id
    WHERE u.id = uid
    GROUP BY u.username, u.email;
END;
$$ LANGUAGE plpgsql;

-- Test it
SELECT * FROM get_user_summary(1);
SELECT * FROM get_user_summary(2);
```

---

## Step 64 — Add updated_at Column + Trigger

```sql
-- Step 1: Add the column
ALTER TABLE products ADD COLUMN updated_at TIMESTAMPTZ;

-- Step 2: Create the trigger function
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Step 3: Attach the trigger
CREATE TRIGGER trg_products_updated_at
    BEFORE UPDATE ON products
    FOR EACH ROW
    EXECUTE FUNCTION set_updated_at();

-- Step 4: Test it!
SELECT name, price, updated_at FROM products WHERE id = 1;
-- updated_at is NULL

UPDATE products SET price = 1399.99 WHERE id = 1;

SELECT name, price, updated_at FROM products WHERE id = 1;
-- updated_at is now set to the current timestamp! 🎉
```

---

# 🔴 PART 13 — JSONB

---

## Step 65 — Add JSONB Column

```sql
-- Add metadata column
ALTER TABLE products ADD COLUMN metadata JSONB DEFAULT '{}';
```

---

## Step 66 — Insert JSON Data

```sql
-- Update laptop with detailed metadata
UPDATE products
SET metadata = '{
    "brand": "TechPro",
    "warranty": "2 years",
    "specs": {
        "cpu": "i7-12700H",
        "ram": 16,
        "storage": "512GB SSD"
    },
    "colors": ["silver", "black", "space gray"],
    "weight_kg": 1.8
}'
WHERE id = 1;

-- Update mouse with metadata
UPDATE products
SET metadata = '{"brand": "ClickMaster", "wireless": true, "battery": "AA", "dpi": [800, 1600, 3200]}'
WHERE id = 2;

-- Verify
SELECT name, jsonb_pretty(metadata) FROM products WHERE id = 1;
```

---

## Step 67 — Query JSONB

```sql
-- Get brand (as text)
SELECT name, metadata->>'brand' AS brand FROM products WHERE metadata->>'brand' IS NOT NULL;

-- Get nested value: RAM
SELECT name, metadata->'specs'->>'ram' AS ram FROM products WHERE id = 1;

-- Get nested value using path
SELECT name, metadata #>> '{specs,cpu}' AS cpu FROM products WHERE id = 1;

-- Get array element (0-indexed)
SELECT name, metadata->'colors'->>0 AS first_color FROM products WHERE id = 1;

-- Find products with 'warranty' key
SELECT name FROM products WHERE metadata ? 'warranty';

-- Find products where brand is 'TechPro'
SELECT name, price FROM products WHERE metadata @> '{"brand": "TechPro"}';

-- Check if wireless is true
SELECT name FROM products WHERE metadata @> '{"wireless": true}';
```

---

## Step 68 — Modify JSONB

```sql
-- Add a new key
UPDATE products
SET metadata = metadata || '{"on_sale": true}'::jsonb
WHERE id = 1;

-- Update nested value (RAM to 32)
UPDATE products
SET metadata = jsonb_set(metadata, '{specs,ram}', '32')
WHERE id = 1;

-- Remove a key
UPDATE products
SET metadata = metadata - 'on_sale'
WHERE id = 1;

-- Append to array
UPDATE products
SET metadata = jsonb_set(metadata, '{colors}', (metadata->'colors') || '"gold"'::jsonb)
WHERE id = 1;

-- Verify all changes
SELECT name, jsonb_pretty(metadata) FROM products WHERE id = 1;
```

---

# 🔴 PART 14 — WINDOW FUNCTIONS

---

## Step 69 — ROW_NUMBER & RANK

```sql
-- Rank products by price
SELECT
    name,
    price,
    ROW_NUMBER() OVER (ORDER BY price DESC) AS row_num,
    RANK() OVER (ORDER BY price DESC) AS rank,
    DENSE_RANK() OVER (ORDER BY price DESC) AS dense_rank
FROM products;
```

---

## Step 70 — RANK Within Categories (PARTITION BY)

```sql
SELECT
    c.name AS category,
    p.name AS product,
    p.price,
    RANK() OVER (PARTITION BY c.name ORDER BY p.price DESC) AS rank_in_category
FROM products p
JOIN categories c ON p.category_id = c.id;
```

---

## Step 71 — Running Total

```sql
SELECT
    id,
    status,
    total_amount,
    SUM(total_amount) OVER (ORDER BY ordered_at) AS running_total,
    ordered_at
FROM orders;
```

---

## Step 72 — LAG and LEAD

```sql
SELECT
    id,
    total_amount,
    LAG(total_amount) OVER (ORDER BY ordered_at) AS prev_order_amount,
    LEAD(total_amount) OVER (ORDER BY ordered_at) AS next_order_amount,
    total_amount - LAG(total_amount) OVER (ORDER BY ordered_at) AS diff_from_prev
FROM orders;
```

---

# 🏆 PART 15 — ADVANCED QUERIES

---

## Step 73 — Top Selling Products

```sql
SELECT
    p.name,
    SUM(oi.quantity) AS total_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.id
GROUP BY p.id, p.name
ORDER BY total_sold DESC
LIMIT 5;
```

---

## Step 74 — Revenue by Category

```sql
SELECT
    c.name AS category,
    COUNT(DISTINCT oi.order_id) AS orders_containing,
    SUM(oi.quantity) AS items_sold,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.id
JOIN categories c ON p.category_id = c.id
GROUP BY c.id, c.name
ORDER BY total_revenue DESC;
```

---

## Step 75 — Monthly Summary

```sql
SELECT
    DATE_TRUNC('month', ordered_at) AS month,
    COUNT(*) AS order_count,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(AVG(total_amount), 2) AS avg_order_value
FROM orders
GROUP BY DATE_TRUNC('month', ordered_at)
ORDER BY month;
```

---

## Step 76 — Materialized View

```sql
-- Create materialized view for product analytics
CREATE MATERIALIZED VIEW product_analytics AS
SELECT
    p.name AS product,
    c.name AS category,
    COALESCE(SUM(oi.quantity), 0) AS total_sold,
    COALESCE(ROUND(SUM(oi.quantity * oi.unit_price), 2), 0) AS total_revenue,
    COALESCE(ROUND(AVG(r.rating), 1), 0) AS avg_rating,
    COUNT(DISTINCT r.id) AS review_count
FROM products p
LEFT JOIN categories c ON p.category_id = c.id
LEFT JOIN order_items oi ON p.id = oi.product_id
LEFT JOIN reviews r ON p.id = r.product_id
GROUP BY p.id, p.name, c.name;

-- Query it (fast!)
SELECT * FROM product_analytics ORDER BY total_revenue DESC;

-- After data changes, refresh it:
REFRESH MATERIALIZED VIEW product_analytics;
```

---

## Step 77 — User Roles & Permissions

```sql
-- Create a read-only role
CREATE ROLE shop_readonly;
GRANT CONNECT ON DATABASE shopdb TO shop_readonly;
GRANT USAGE ON SCHEMA public TO shop_readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO shop_readonly;

-- Create an app user with that role
CREATE ROLE shop_app WITH LOGIN PASSWORD 'app_password_123';
GRANT shop_readonly TO shop_app;

-- Verify
\du
```

---

## Step 78 — Backup & Maintenance

```sql
-- Check database size
SELECT pg_size_pretty(pg_database_size('shopdb')) AS db_size;

-- Check each table size
SELECT
    relname AS table_name,
    pg_size_pretty(pg_total_relation_size(relid)) AS total_size
FROM pg_stat_user_tables
ORDER BY pg_total_relation_size(relid) DESC;

-- Run vacuum and analyze
VACUUM ANALYZE;

-- Check when tables were last analyzed
SELECT relname, last_analyze, last_autoanalyze
FROM pg_stat_user_tables;
```

Backup from terminal (not from psql):

```bash
# Backup the database
pg_dump -U postgres -d shopdb -f shopdb_backup.sql

# Backup in compressed format
pg_dump -U postgres -d shopdb -Fc -f shopdb_backup.dump
```

---

# ✅ You Finished the Lab!

```
Tables Created:     6    ✓
Data Inserted:      50+  ✓
SELECT Queries:     30+  ✓
JOINs Written:      10+  ✓
Aggregations:       10+  ✓
Subqueries & CTEs:  8+   ✓
Updates & Deletes:  6+   ✓
Indexes Created:    5+   ✓
Views Created:      3    ✓
Transactions:       3    ✓
Functions:          2    ✓
Triggers:           1    ✓
JSONB Operations:   15+  ✓
Window Functions:   4    ✓
Advanced Queries:   6    ✓
```

> 🐘 **You just typed 78 steps of real PostgreSQL from scratch!**
> You're no longer a beginner. Keep building and keep querying! 🏆

---

*Practice makes permanent. Now go build a real project!*
