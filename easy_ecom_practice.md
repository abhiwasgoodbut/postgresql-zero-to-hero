# 🛍️ Simple & Modern E-Commerce Database Guide

> **Why this database?**  
> `dvdrental` is an old 2005 database with confusing tables (`inventory`, `staff`, `store`, `film_actor`, `address`).  
> This **`ecom_db`** is modern, clean, and intuitive. It models a real store like Amazon/Apple with products you actually know (iPhone, MacBook, PS5, AirPods).

---

## 🏗️ The 6 Simple Tables

```
  ┌─────────────┐         ┌─────────────┐
  │    users    │         │ categories  │
  ├─────────────┤         ├─────────────┤
  │ id          │         │ id          │
  │ name        │         │ name        │
  │ email       │         │ slug        │
  │ city        │         └──────┬──────┘
  │ age         │                │
  │ is_premium  │                │ 1
  └──────┬──────┘                │
         │ 1                     │ has many
         │                       │
         │ places                ▼ *
         ▼ *              ┌─────────────┐
  ┌─────────────┐ 1     * │  products   │
  │   orders    │◄────────┤─────────────┤
  ├─────────────┤         │ id          │
  │ id          │         │ title       │
  │ user_id     │         │ category_id │
  │ status      │         │ price       │
  │ total_amount│         │ stock       │
  │ order_date  │         │ brand       │
  └──────┬──────┘         └──────┬──────┘
         │ 1                     │ 1
         │ contains              │ rated in
         ▼ *                     ▼ *
  ┌─────────────┐         ┌─────────────┐
  │ order_items │         │   reviews   │
  ├─────────────┤         ├─────────────┤
  │ id          │         │ id          │
  │ order_id    │         │ user_id     │
  │ product_id  │         │ product_id  │
  │ quantity    │         │ rating (1-5)│
  │ unit_price  │         │ comment     │
  └─────────────┘         └─────────────┘
```

---

## ⚡ How to Set Up in 10 Seconds

### Step 1: Open terminal / Command Prompt & connect to PostgreSQL
```bash
psql -U postgres
```

### Step 2: Create and connect to the new database
```sql
CREATE DATABASE ecom_db;
\c ecom_db
```

### Step 3: Run the setup script
```sql
\i 'c:/TV/Nostalgia hit/football/ecom_database.sql'
```

*Done! You now have 6 clean tables with realistic data.*

---

## 🎯 15 Fun & Useful Practice Queries (Try them!)

### 1. View All Products with Nice Formatting
```sql
\pset border 2
\pset linestyle unicode
SELECT id, title, brand, price, stock FROM products;
```

---

### 2. Find all Apple products under $1000
```sql
SELECT title, price, stock 
FROM products 
WHERE brand = 'Apple' AND price < 1000;
```

---

### 3. Join Products with Category Names (INNER JOIN)
```sql
SELECT 
    p.title AS product, 
    p.brand, 
    p.price, 
    c.name AS category
FROM products p
JOIN categories c ON p.category_id = c.id
ORDER BY p.price DESC;
```

---

### 4. Who bought what? (3-Table JOIN)
```sql
SELECT 
    u.name AS customer, 
    o.id AS order_id, 
    p.title AS product, 
    oi.quantity, 
    oi.unit_price
FROM users u
JOIN orders o ON u.id = o.user_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id;
```

---

### 5. Top Spenders (GROUP BY & SUM)
```sql
SELECT 
    u.name AS customer, 
    u.city, 
    COUNT(o.id) AS total_orders, 
    SUM(o.total_amount) AS total_spent
FROM users u
JOIN orders o ON u.id = o.user_id
GROUP BY u.id, u.name, u.city
ORDER BY total_spent DESC;
```

---

### 6. Best-Selling Products by Quantity Sold
```sql
SELECT 
    p.title AS product, 
    p.brand, 
    SUM(oi.quantity) AS units_sold, 
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.id
GROUP BY p.id, p.title, p.brand
ORDER BY units_sold DESC;
```

---

### 7. Product Average Ratings & Review Counts
```sql
SELECT 
    p.title, 
    ROUND(AVG(r.rating), 1) AS avg_rating, 
    COUNT(r.id) AS review_count
FROM products p
LEFT JOIN reviews r ON p.id = r.product_id
GROUP BY p.id, p.title
ORDER BY avg_rating DESC NULLS LAST;
```

---

### 8. Find users who have NEVER ordered anything (LEFT JOIN trick)
```sql
SELECT 
    u.name, 
    u.email, 
    u.city
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
WHERE o.id IS NULL;
```

---

### 9. Products that have ZERO reviews
```sql
SELECT 
    p.title, 
    p.brand, 
    p.price
FROM products p
LEFT JOIN reviews r ON p.id = r.product_id
WHERE r.id IS NULL;
```

---

### 10. Total Revenue by Category
```sql
SELECT 
    c.name AS category, 
    COUNT(DISTINCT oi.order_id) AS total_orders,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM categories c
JOIN products p ON c.id = p.category_id
JOIN order_items oi ON p.id = oi.product_id
GROUP BY c.id, c.name
ORDER BY revenue DESC;
```

---

### 11. Most Expensive Product in Each Category (Window Function)
```sql
SELECT 
    c.name AS category, 
    p.title, 
    p.price,
    RANK() OVER (PARTITION BY c.id ORDER BY p.price DESC) AS price_rank
FROM products p
JOIN categories c ON p.category_id = c.id;
```

---

### 12. Monthly Sales Overview
```sql
SELECT 
    DATE_TRUNC('month', order_date) AS month, 
    COUNT(*) AS total_orders, 
    SUM(total_amount) AS revenue,
    ROUND(AVG(total_amount), 2) AS avg_order_value
FROM orders
GROUP BY DATE_TRUNC('month', order_date);
```

---

### 13. Subquery: Products priced above the overall average
```sql
SELECT title, price, brand
FROM products
WHERE price > (SELECT AVG(price) FROM products)
ORDER BY price DESC;
```

---

### 14. Premium Users Spending Comparison
```sql
SELECT 
    CASE WHEN u.is_premium THEN 'Premium Customer' ELSE 'Standard Customer' END AS user_type,
    COUNT(DISTINCT u.id) AS user_count,
    ROUND(AVG(o.total_amount), 2) AS avg_order_amount,
    SUM(o.total_amount) AS total_revenue
FROM users u
JOIN orders o ON u.id = o.user_id
GROUP BY u.is_premium;
```

---

### 15. Create a Reusable View: Customer Dashboard
```sql
CREATE OR REPLACE VIEW customer_summary AS
SELECT 
    u.id AS user_id,
    u.name,
    u.city,
    u.is_premium,
    COUNT(DISTINCT o.id) AS orders_count,
    COALESCE(SUM(o.total_amount), 0) AS total_spent,
    COUNT(DISTINCT r.id) AS reviews_written
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
LEFT JOIN reviews r ON u.id = r.user_id
GROUP BY u.id, u.name, u.city, u.is_premium;

-- Query the view anytime!
SELECT * FROM customer_summary ORDER BY total_spent DESC;
```
