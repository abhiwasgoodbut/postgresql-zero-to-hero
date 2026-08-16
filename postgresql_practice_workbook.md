# 🐘 PostgreSQL Practice Workbook — Write It Yourself!

> **How to use this file:**
> 1. Open `psql` or pgAdmin alongside this file
> 2. Read each exercise instruction
> 3. Write your SQL in the empty code blocks (replace the `-- YOUR CODE HERE` comments)
> 4. Run it in psql and verify the output
> 5. Check the ✅ Expected Result to confirm you got it right
> 6. Mark the checkbox `[ ]` → `[x]` when done
>
> **Rule**: Don't copy from the course guide. Try writing from memory first. Only peek if you're truly stuck.

---

## 🗄️ Project: We're Building an E-Commerce Database!

Throughout this workbook, you'll build a **complete e-commerce database** called `shopdb` from scratch. By the end, you'll have tables for users, products, categories, orders, reviews, and more — all connected with proper relationships.

---

# Module 1 — Setup & First Commands

## Exercise 1.1 — Connect to PostgreSQL
- [ ] Open your terminal and connect to PostgreSQL as the `postgres` user.

```
-- Write the psql command to connect (this is a terminal command, not SQL):

```

✅ Expected: You see `postgres=#` prompt

---

## Exercise 1.2 — Check Your Version
- [ ] Write a query to check your PostgreSQL version.

```sql
-- YOUR CODE HERE

```

✅ Expected: Something like `PostgreSQL 17.x on x86_64-...`

---

## Exercise 1.3 — List All Databases
- [ ] Use the psql meta-command to list all existing databases.

```
-- YOUR CODE HERE (hint: it's a backslash command)

```

✅ Expected: A table showing `postgres`, `template0`, `template1` databases

---

## Exercise 1.4 — Create Our Project Database
- [ ] Create a new database called `shopdb`.

```sql
-- YOUR CODE HERE

```

---

## Exercise 1.5 — Connect to shopdb
- [ ] Switch to the `shopdb` database.

```
-- YOUR CODE HERE

```

✅ Expected: `You are now connected to database "shopdb"`

---

## Exercise 1.6 — Verify Current Database
- [ ] Write a query to confirm which database you're connected to.

```sql
-- YOUR CODE HERE

```

✅ Expected: `shopdb`

---

# Module 2 — Creating Tables

## Exercise 2.1 — Create the `users` Table
- [ ] Create a `users` table with the following columns:

| Column | Type | Constraints |
|---|---|---|
| id | auto-incrementing integer | primary key |
| username | max 50 chars | unique, not null |
| email | max 255 chars | unique, not null |
| password_hash | max 255 chars | not null |
| full_name | max 100 chars | not null |
| age | integer | must be >= 13 |
| is_active | boolean | default true |
| created_at | timestamp with timezone | default current time |

```sql
-- YOUR CODE HERE










```

✅ Verify: Run `\d users` — you should see all columns with correct types and constraints

---

## Exercise 2.2 — Create the `categories` Table
- [ ] Create a `categories` table:

| Column | Type | Constraints |
|---|---|---|
| id | auto-incrementing integer | primary key |
| name | max 100 chars | unique, not null |
| description | unlimited text | optional |

```sql
-- YOUR CODE HERE




```

---

## Exercise 2.3 — Create the `products` Table
- [ ] Create a `products` table with a **foreign key** to `categories`:

| Column | Type | Constraints |
|---|---|---|
| id | auto-incrementing integer | primary key |
| name | max 200 chars | not null |
| description | unlimited text | optional |
| price | decimal (10, 2) | not null, must be >= 0 |
| stock | integer | not null, default 0, must be >= 0 |
| category_id | integer | foreign key → categories(id), ON DELETE SET NULL |
| is_available | boolean | default true |
| created_at | timestamp with timezone | default current time |

```sql
-- YOUR CODE HERE












```

✅ Verify: Run `\d products` — check that the foreign key constraint appears

---

## Exercise 2.4 — Create the `orders` Table
- [ ] Create an `orders` table linked to `users`:

| Column | Type | Constraints |
|---|---|---|
| id | auto-incrementing integer | primary key |
| user_id | integer | foreign key → users(id), ON DELETE CASCADE, not null |
| status | max 20 chars | default 'pending' |
| total_amount | decimal (10, 2) | not null, must be >= 0 |
| shipping_address | unlimited text | not null |
| ordered_at | timestamp with timezone | default current time |

```sql
-- YOUR CODE HERE










```

---

## Exercise 2.5 — Create the `order_items` Table (Junction Table!)
- [ ] Create `order_items` to link orders with products (many-to-many through orders):

| Column | Type | Constraints |
|---|---|---|
| id | auto-incrementing integer | primary key |
| order_id | integer | foreign key → orders(id), ON DELETE CASCADE, not null |
| product_id | integer | foreign key → products(id), ON DELETE RESTRICT, not null |
| quantity | integer | not null, must be > 0 |
| unit_price | decimal (10, 2) | not null |

```sql
-- YOUR CODE HERE









```

---

## Exercise 2.6 — Create the `reviews` Table
- [ ] Create a `reviews` table linked to both `users` and `products`:

| Column | Type | Constraints |
|---|---|---|
| id | auto-incrementing integer | primary key |
| user_id | integer | foreign key → users(id), ON DELETE CASCADE, not null |
| product_id | integer | foreign key → products(id), ON DELETE CASCADE, not null |
| rating | smallint | not null, must be between 1 and 5 |
| comment | unlimited text | optional |
| created_at | timestamp with timezone | default current time |
| (constraint) | | same user can't review same product twice: UNIQUE(user_id, product_id) |

```sql
-- YOUR CODE HERE











```

---

## Exercise 2.7 — Verify All Tables
- [ ] List all tables you just created.

```
-- YOUR CODE HERE (psql meta-command)

```

✅ Expected: 6 tables — `users`, `categories`, `products`, `orders`, `order_items`, `reviews`

---

# Module 3 — INSERT Data (Populating Our Shop)

## Exercise 3.1 — Insert Users
- [ ] Insert 6 users into the `users` table. Use `RETURNING *` on at least one.

```sql
-- Insert user 1 with RETURNING
-- YOUR CODE HERE



-- Insert remaining 5 users in a single INSERT statement
-- YOUR CODE HERE
-- Use these names: Bob Wilson, Charlie Kumar, Diana Chen, Eve Martinez, Frank Ahmed
-- Use emails: bob@mail.com, charlie@mail.com, diana@mail.com, eve@mail.com, frank@mail.com
-- Use ages: 30, 22, 28, 35, 19
-- Make up password_hash values (e.g., 'hash_bob123')






```

---

## Exercise 3.2 — Insert Categories
- [ ] Insert 5 categories:

Categories: Electronics, Clothing, Books, Home & Kitchen, Sports

```sql
-- YOUR CODE HERE (insert all 5 in one statement)





```

---

## Exercise 3.3 — Insert Products
- [ ] Insert at least 10 products across different categories. Here are some ideas:

| Product | Price | Stock | Category |
|---|---|---|---|
| Laptop Pro 15 | 1299.99 | 50 | Electronics |
| Wireless Mouse | 29.99 | 200 | Electronics |
| USB-C Hub | 49.99 | 150 | Electronics |
| Men's T-Shirt | 19.99 | 300 | Clothing |
| Running Shoes | 89.99 | 100 | Clothing |
| JavaScript: The Good Parts | 35.00 | 75 | Books |
| Database Design Book | 45.00 | 60 | Books |
| Coffee Maker | 79.99 | 80 | Home & Kitchen |
| Yoga Mat | 24.99 | 120 | Sports |
| Basketball | 29.99 | 90 | Sports |

> **Hint**: You need to use the correct `category_id` numbers. If Electronics was the first category you inserted, its `id` is probably 1. Check with `SELECT * FROM categories;` first.

```sql
-- First, check your category IDs:
-- SELECT id, name FROM categories;

-- Now insert 10 products (use correct category_id values):
-- YOUR CODE HERE













```

---

## Exercise 3.4 — Insert Orders
- [ ] Create 5 orders for different users. Vary the status (pending, confirmed, shipped, delivered).

```sql
-- YOUR CODE HERE
-- Remember: user_id must reference an existing user
-- status options: 'pending', 'confirmed', 'shipped', 'delivered'
-- shipping_address: make up addresses








```

---

## Exercise 3.5 — Insert Order Items
- [ ] Add items to each order. Some orders should have multiple items.

```sql
-- YOUR CODE HERE
-- Remember: order_id and product_id must reference existing records
-- unit_price should match the product's price
-- quantity must be > 0










```

---

## Exercise 3.6 — Insert Reviews
- [ ] Add at least 8 reviews from different users for different products.

```sql
-- YOUR CODE HERE
-- rating must be 1-5
-- Remember: same user can't review the same product twice (UNIQUE constraint)











```

---

## Exercise 3.7 — Test a Constraint!
- [ ] Try inserting a review with rating = 6. What happens?
- [ ] Try inserting a duplicate review (same user_id + product_id). What happens?

```sql
-- Test 1: Invalid rating
-- YOUR CODE HERE


-- Test 2: Duplicate review
-- YOUR CODE HERE

```

✅ Expected: Both should give you ERROR messages. Write the error messages you see below:

```
Error 1: 
Error 2: 
```

---

# Module 4 — SELECT Queries (Reading Data)

## Exercise 4.1 — Basic SELECT
- [ ] Get all users (all columns).
- [ ] Get only the names and emails of all users.
- [ ] Get all products sorted by price (cheapest first).

```sql
-- All users:
-- YOUR CODE HERE

-- Names and emails only:
-- YOUR CODE HERE

-- Products sorted by price ascending:
-- YOUR CODE HERE

```

---

## Exercise 4.2 — SELECT with Aliases
- [ ] Get product name, price, and a calculated column "price_with_tax" (price * 1.18) rounded to 2 decimals.

```sql
-- YOUR CODE HERE



```

✅ Expected: Each row shows product name, price, and an 18% tax-inclusive price

---

## Exercise 4.3 — DISTINCT
- [ ] Get all unique statuses from the orders table.

```sql
-- YOUR CODE HERE

```

---

## Exercise 4.4 — COUNT
- [ ] Count total users.
- [ ] Count total products.
- [ ] Count total orders.

```sql
-- YOUR CODE HERE



```

---

# Module 5 — WHERE Clause (Filtering)

## Exercise 5.1 — Comparison Operators
- [ ] Find all products with price greater than 50.
- [ ] Find all users who are 25 or younger.
- [ ] Find all orders that are NOT 'pending'.

```sql
-- Products over $50:
-- YOUR CODE HERE

-- Users 25 or younger:
-- YOUR CODE HERE

-- Non-pending orders:
-- YOUR CODE HERE

```

---

## Exercise 5.2 — AND / OR / NOT
- [ ] Find products that cost between $20 and $50 (use AND, not BETWEEN).
- [ ] Find users who are either younger than 20 OR older than 30.

```sql
-- Products $20-$50:
-- YOUR CODE HERE

-- Users under 20 or over 30:
-- YOUR CODE HERE

```

---

## Exercise 5.3 — IN and NOT IN
- [ ] Find orders with status 'shipped' or 'delivered' (use IN).
- [ ] Find products NOT in category 1 or 2 (use NOT IN).

```sql
-- Shipped or delivered orders:
-- YOUR CODE HERE

-- Products not in category 1 or 2:
-- YOUR CODE HERE

```

---

## Exercise 5.4 — BETWEEN
- [ ] Find products priced between $25 and $100.
- [ ] Find users with age between 20 and 30.

```sql
-- YOUR CODE HERE


```

---

## Exercise 5.5 — LIKE and ILIKE
- [ ] Find users whose username starts with 'a'.
- [ ] Find products whose name contains 'book' (case-insensitive).
- [ ] Find users whose email ends with '@mail.com'.

```sql
-- Username starts with 'a':
-- YOUR CODE HERE

-- Product name contains 'book' (case-insensitive):
-- YOUR CODE HERE

-- Email ends with '@mail.com':
-- YOUR CODE HERE

```

---

## Exercise 5.6 — IS NULL / IS NOT NULL
- [ ] Find products with no description (NULL).
- [ ] Find products that DO have a description.

```sql
-- No description:
-- YOUR CODE HERE

-- Has description:
-- YOUR CODE HERE

```

---

## Exercise 5.7 — ORDER BY with LIMIT and OFFSET
- [ ] Get the 3 most expensive products.
- [ ] Get the 3 cheapest products.
- [ ] Get products 4-6 when sorted by price ascending (page 2, 3 per page).

```sql
-- 3 most expensive:
-- YOUR CODE HERE

-- 3 cheapest:
-- YOUR CODE HERE

-- Page 2 (items 4-6) of cheapest products:
-- YOUR CODE HERE

```

---

# Module 6 — JOINs (The Big One!)

## Exercise 6.1 — INNER JOIN
- [ ] Get all products with their category name. Show product name, price, and category name.

```sql
-- YOUR CODE HERE




```

✅ Expected: Only products that have a category assigned appear

---

## Exercise 6.2 — LEFT JOIN
- [ ] Get ALL products with their category name, including products with no category.

```sql
-- YOUR CODE HERE




```

✅ Expected: Products with `NULL` category also appear

---

## Exercise 6.3 — JOIN Users with Orders
- [ ] Get all orders with the username of who placed them. Show username, order status, total_amount, ordered_at.

```sql
-- YOUR CODE HERE




```

---

## Exercise 6.4 — LEFT JOIN to Find Users Without Orders
- [ ] Find all users who have NEVER placed an order.

```sql
-- YOUR CODE HERE
-- Hint: LEFT JOIN users with orders, then filter WHERE order id IS NULL




```

✅ Expected: Users who don't appear in the orders table

---

## Exercise 6.5 — Three-Table JOIN
- [ ] Get order details showing: username, product name, quantity, unit_price.
- [ ] This requires joining: orders → order_items → products, and also orders → users.

```sql
-- YOUR CODE HERE
-- Join 4 tables: users, orders, order_items, products






```

---

## Exercise 6.6 — JOIN with Reviews
- [ ] Get all reviews showing: username, product name, rating, comment.
- [ ] Sort by rating descending.

```sql
-- YOUR CODE HERE






```

---

## Exercise 6.7 — Products Without Reviews
- [ ] Find all products that have NOT been reviewed yet.

```sql
-- YOUR CODE HERE
-- Hint: LEFT JOIN products with reviews, filter WHERE review id IS NULL



```

---

# Module 7 — Aggregate Functions & GROUP BY

## Exercise 7.1 — Basic Aggregates
- [ ] Find the total number of products.
- [ ] Find the average product price.
- [ ] Find the cheapest and most expensive product price.
- [ ] Find the total value of all stock (SUM of price * stock).

```sql
-- Total products:
-- YOUR CODE HERE

-- Average price (round to 2 decimals):
-- YOUR CODE HERE

-- Min and max price:
-- YOUR CODE HERE

-- Total stock value:
-- YOUR CODE HERE

```

---

## Exercise 7.2 — GROUP BY
- [ ] Count how many products are in each category. Show category name and count.

```sql
-- YOUR CODE HERE




```

---

## Exercise 7.3 — GROUP BY with Multiple Aggregates
- [ ] For each category, show: category name, number of products, average price, cheapest price, most expensive price.

```sql
-- YOUR CODE HERE






```

---

## Exercise 7.4 — GROUP BY with Orders
- [ ] For each user, show: username, number of orders, total amount spent.
- [ ] Sort by total spent descending.

```sql
-- YOUR CODE HERE






```

---

## Exercise 7.5 — HAVING
- [ ] Find categories that have more than 2 products.
- [ ] Find users who have spent more than $100 total.

```sql
-- Categories with > 2 products:
-- YOUR CODE HERE




-- Users who spent > $100:
-- YOUR CODE HERE




```

---

## Exercise 7.6 — Average Rating per Product
- [ ] Show each product's name, average rating (rounded to 1 decimal), and number of reviews.
- [ ] Only show products that have at least 2 reviews.
- [ ] Sort by average rating descending.

```sql
-- YOUR CODE HERE







```

---

# Module 8 — Subqueries & CTEs

## Exercise 8.1 — Subquery in WHERE
- [ ] Find all products that cost more than the average product price.

```sql
-- YOUR CODE HERE



```

---

## Exercise 8.2 — Subquery with IN
- [ ] Find all users who have placed at least one order (use a subquery, not a JOIN).

```sql
-- YOUR CODE HERE



```

---

## Exercise 8.3 — Subquery with EXISTS
- [ ] Find all products that have at least one review (use EXISTS).

```sql
-- YOUR CODE HERE




```

---

## Exercise 8.4 — Subquery in SELECT
- [ ] For each user, show their name and total number of orders (use a subquery in SELECT, not a JOIN).

```sql
-- YOUR CODE HERE




```

---

## Exercise 8.5 — Basic CTE
- [ ] Using a CTE called `expensive_products`, find products priced above $50, then select only those in the 'Electronics' category.

```sql
-- YOUR CODE HERE






```

---

## Exercise 8.6 — Multiple CTEs
- [ ] CTE 1: `user_spending` — calculate total spent per user_id
- [ ] CTE 2: `user_info` — get id, username, email from users
- [ ] Main query: Join them to show username, email, and total_spent. Sort by total_spent DESC.

```sql
-- YOUR CODE HERE










```

---

# Module 9 — UPDATE & DELETE

## Exercise 9.1 — Basic UPDATE
- [ ] Increase the price of all Electronics products by 10%.

```sql
-- YOUR CODE HERE
-- Hint: You'll need a subquery or know the category_id for Electronics



```

---

## Exercise 9.2 — UPDATE with RETURNING
- [ ] Set all orders with status 'pending' to 'confirmed'. Return the updated rows.

```sql
-- YOUR CODE HERE



```

---

## Exercise 9.3 — UPDATE with a Subquery
- [ ] Deactivate (set is_active = false) all users who have never placed an order.

```sql
-- YOUR CODE HERE




```

---

## Exercise 9.4 — DELETE
- [ ] Delete all reviews with a rating of 1. Use RETURNING to see what was deleted.

```sql
-- YOUR CODE HERE


```

---

## Exercise 9.5 — UPSERT (ON CONFLICT)
- [ ] Try to insert a category 'Electronics'. If it already exists, update its description to 'Gadgets and devices'.

```sql
-- YOUR CODE HERE




```

---

# Module 10 — Indexes & Performance

## Exercise 10.1 — EXPLAIN a Query
- [ ] Run EXPLAIN ANALYZE on: `SELECT * FROM products WHERE price > 50;`
- [ ] Write down whether it used a Seq Scan or Index Scan.

```sql
-- YOUR CODE HERE


```

**Did it use Seq Scan or Index Scan?**:

---

## Exercise 10.2 — Create an Index
- [ ] Create an index on `products(price)`.
- [ ] Run the same EXPLAIN ANALYZE query from 10.1 again.

```sql
-- Create index:
-- YOUR CODE HERE

-- Run EXPLAIN ANALYZE again:
-- YOUR CODE HERE

```

**Did the scan type change?**:

---

## Exercise 10.3 — Create More Useful Indexes
- [ ] Create an index on `users(email)` — emails are frequently searched.
- [ ] Create an index on `orders(user_id)` — for JOIN performance.
- [ ] Create an index on `reviews(product_id)` — for product review lookups.

```sql
-- YOUR CODE HERE



```

---

## Exercise 10.4 — List All Indexes
- [ ] List all indexes on the `products` table.

```sql
-- YOUR CODE HERE (psql meta-command or SQL query)

```

---

## Exercise 10.5 — Check Index Sizes
- [ ] Check the total size of the `products` table including indexes.

```sql
-- YOUR CODE HERE

```

---

# Module 11 — Views

## Exercise 11.1 — Create a View
- [ ] Create a view called `product_overview` that shows: product name, category name, price, stock, average rating, review count.

```sql
-- YOUR CODE HERE









```

---

## Exercise 11.2 — Use the View
- [ ] Query the view to find all products with average rating above 3.
- [ ] Query the view to find products in 'Electronics'.

```sql
-- Rating above 3:
-- YOUR CODE HERE

-- Electronics products:
-- YOUR CODE HERE

```

---

## Exercise 11.3 — Create a View for User Dashboard
- [ ] Create a view called `user_dashboard` showing: username, email, total orders, total spent, average order value, account created date.

```sql
-- YOUR CODE HERE










```

---

# Module 12 — Transactions

## Exercise 12.1 — Basic Transaction
- [ ] Write a transaction that:
  1. Creates a new order for user 1
  2. Adds 2 items to that order
  3. Updates the stock of those products
  4. Commits everything

```sql
-- YOUR CODE HERE
-- Step 1: BEGIN the transaction

-- Step 2: Insert a new order (use RETURNING id to get the order_id)

-- Step 3: Insert order items

-- Step 4: Update product stock (decrease by quantity ordered)

-- Step 5: COMMIT









```

---

## Exercise 12.2 — Transaction with ROLLBACK
- [ ] Start a transaction, insert a fake user, then ROLLBACK. Verify the user was NOT created.

```sql
-- YOUR CODE HERE




-- Verify: SELECT * FROM users WHERE username = 'fake_user';
-- YOUR CODE HERE

```

✅ Expected: The fake user should NOT exist after rollback

---

## Exercise 12.3 — Savepoint
- [ ] Start a transaction. Insert a valid order. Set a savepoint. Insert an order item with wrong data. Rollback to savepoint. Insert the correct order item. Commit.

```sql
-- YOUR CODE HERE










```

---

# Module 13 — Functions

## Exercise 13.1 — Create a Tax Calculator Function
- [ ] Create a function `calculate_total(price DECIMAL, quantity INTEGER, tax_rate DECIMAL DEFAULT 0.18)` that returns the total with tax.

Formula: `price * quantity * (1 + tax_rate)`

```sql
-- YOUR CODE HERE







-- Test it:
-- SELECT calculate_total(100, 2);          -- Expected: 236.00
-- SELECT calculate_total(100, 2, 0.10);    -- Expected: 220.00
```

---

## Exercise 13.2 — Create a Function That Returns User Summary
- [ ] Create a function `get_user_summary(uid INTEGER)` that returns a table with: username, email, order_count, total_spent.

```sql
-- YOUR CODE HERE











-- Test it:
-- SELECT * FROM get_user_summary(1);
```

---

# Module 14 — Triggers

## Exercise 14.1 — Auto-Update Timestamp Trigger
- [ ] Add an `updated_at` column to the `products` table.
- [ ] Create a trigger function that sets `updated_at = NOW()` before every UPDATE.
- [ ] Attach the trigger to the `products` table.
- [ ] Test it by updating a product's price.

```sql
-- Step 1: Add the column
-- YOUR CODE HERE

-- Step 2: Create the trigger function
-- YOUR CODE HERE





-- Step 3: Create the trigger
-- YOUR CODE HERE



-- Step 4: Test it
-- YOUR CODE HERE


-- Verify: SELECT name, price, updated_at FROM products WHERE id = 1;
```

---

## Exercise 14.2 — Stock Update Trigger
- [ ] Create a trigger that automatically decreases product stock when a new order_item is inserted.

```sql
-- Create the trigger function
-- YOUR CODE HERE








-- Attach the trigger
-- YOUR CODE HERE



-- Test: Insert an order item and check if stock decreased
-- YOUR CODE HERE


```

---

# Module 15 — JSONB

## Exercise 15.1 — Add a JSONB Column
- [ ] Add a `metadata` column (JSONB, default '{}') to the `products` table.

```sql
-- YOUR CODE HERE

```

---

## Exercise 15.2 — Update with JSON Data
- [ ] Update the Laptop product with this metadata: `{"brand": "TechPro", "warranty": "2 years", "specs": {"ram": 16, "storage": "512GB"}, "colors": ["silver", "black"]}`

```sql
-- YOUR CODE HERE




```

---

## Exercise 15.3 — Query JSONB
- [ ] Extract the brand from the laptop's metadata.
- [ ] Extract the RAM from specs (nested).
- [ ] Check if the metadata has a 'warranty' key.

```sql
-- Get brand (as text):
-- YOUR CODE HERE

-- Get RAM (nested):
-- YOUR CODE HERE

-- Products that have 'warranty' key:
-- YOUR CODE HERE

```

---

## Exercise 15.4 — Modify JSONB
- [ ] Add a new key `"weight": "1.8kg"` to the laptop's metadata.
- [ ] Update the RAM to 32 in specs.
- [ ] Append "white" to the colors array.

```sql
-- Add weight:
-- YOUR CODE HERE

-- Update RAM:
-- YOUR CODE HERE

-- Append to colors array:
-- YOUR CODE HERE

```

---

# Module 16 — Window Functions

## Exercise 16.1 — ROW_NUMBER
- [ ] Rank all products by price (most expensive first). Show product name, price, and rank.

```sql
-- YOUR CODE HERE




```

---

## Exercise 16.2 — RANK within Categories
- [ ] Rank products within each category by price. Show category name, product name, price, and rank within category.

```sql
-- YOUR CODE HERE






```

---

## Exercise 16.3 — Running Total
- [ ] Show orders with a running total of `total_amount`, ordered by `ordered_at`.

```sql
-- YOUR CODE HERE




```

---

## Exercise 16.4 — LAG / LEAD
- [ ] For each order (sorted by date), show the current amount, previous order amount, and the difference.

```sql
-- YOUR CODE HERE






```

---

# Module 17 — Advanced Queries Challenge

## Exercise 17.1 — Top Selling Products
- [ ] Find the top 3 best-selling products (by total quantity sold across all orders).

```sql
-- YOUR CODE HERE






```

---

## Exercise 17.2 — Revenue by Category
- [ ] Calculate total revenue per category (sum of unit_price * quantity from order_items, grouped by category).

```sql
-- YOUR CODE HERE







```

---

## Exercise 17.3 — Users Who Reviewed but Never Bought
- [ ] Find users who have written a review but have never placed an order.

```sql
-- YOUR CODE HERE





```

---

## Exercise 17.4 — Monthly Order Summary
- [ ] Show a monthly summary: month, number of orders, total revenue, average order value.
- [ ] Use `DATE_TRUNC`.

```sql
-- YOUR CODE HERE






```

---

## Exercise 17.5 — Product Recommendation Query
- [ ] Find products that were bought by users who also bought product ID 1 ("people who bought X also bought Y").
- [ ] Exclude product 1 itself from results.

```sql
-- YOUR CODE HERE
-- This is a challenging one! Think about it step by step:
-- 1. Find users who bought product 1
-- 2. Find other products those users bought
-- 3. Exclude product 1








```

---

# Module 18 — ALTER Table Exercises

## Exercise 18.1 — Add a Column
- [ ] Add a `phone` column (VARCHAR(20)) to the `users` table.

```sql
-- YOUR CODE HERE

```

---

## Exercise 18.2 — Rename a Column
- [ ] Rename the `full_name` column in `users` to `display_name`.

```sql
-- YOUR CODE HERE

```

---

## Exercise 18.3 — Drop a Column
- [ ] Drop the `phone` column you just added.

```sql
-- YOUR CODE HERE

```

---

## Exercise 18.4 — Add a Constraint After Table Creation
- [ ] Add a CHECK constraint to `orders` ensuring `total_amount` is less than 100000.

```sql
-- YOUR CODE HERE

```

---

# Module 19 — User Management

## Exercise 19.1 — Create a Read-Only Role
- [ ] Create a role called `shop_readonly` (no login).
- [ ] Grant SELECT on all tables in public schema.

```sql
-- YOUR CODE HERE



```

---

## Exercise 19.2 — Create an App User
- [ ] Create a role `shop_app` with login and password.
- [ ] Grant SELECT, INSERT, UPDATE, DELETE on all tables.
- [ ] Grant usage on all sequences.

```sql
-- YOUR CODE HERE




```

---

# Module 20 — Backup & Cleanup

## Exercise 20.1 — Check Table Sizes
- [ ] Write a query that shows each table's name and size (pretty-printed).

```sql
-- YOUR CODE HERE




```

---

## Exercise 20.2 — Check Database Size
- [ ] Check the total size of the `shopdb` database.

```sql
-- YOUR CODE HERE

```

---

## Exercise 20.3 — Backup Your Database
- [ ] Write the `pg_dump` command (terminal, not SQL) to backup `shopdb` to a file called `shopdb_backup.sql`.

```bash
# YOUR COMMAND HERE

```

---

## Exercise 20.4 — VACUUM
- [ ] Run VACUUM ANALYZE on all tables.

```sql
-- YOUR CODE HERE

```

---

# 🏆 Final Boss Challenge

## Challenge 1 — Complex Report Query
- [ ] Write a SINGLE query that produces this report for each user:

| username | total_orders | total_spent | avg_order_value | products_bought | reviews_written | avg_rating_given | favorite_category |
|---|---|---|---|---|---|---|---|

> **Hint**: This will require multiple JOINs, subqueries or CTEs, and aggregate functions. `favorite_category` = the category they've bought the most products from.

```sql
-- YOUR CODE HERE
-- Take your time with this one. Break it down into CTEs.

















```

---

## Challenge 2 — Create a Materialized View
- [ ] Create a materialized view called `product_analytics` that pre-computes: product_name, category, total_sold, total_revenue, avg_rating, review_count.
- [ ] Create a unique index on it.
- [ ] Refresh it.

```sql
-- YOUR CODE HERE












```

---

## Challenge 3 — Full Text Search
- [ ] Add a search_vector column to products.
- [ ] Populate it from name + description.
- [ ] Create a GIN index on it.
- [ ] Search for products matching 'laptop' or 'wireless'.

```sql
-- YOUR CODE HERE









```

---

# ✅ Progress Tracker

Count your completed exercises and track your progress!

| Module | Exercises | Completed |
|---|---|---|
| Module 1 — Setup | 6 | /6 |
| Module 2 — Create Tables | 7 | /7 |
| Module 3 — INSERT | 7 | /7 |
| Module 4 — SELECT | 4 | /4 |
| Module 5 — WHERE | 7 | /7 |
| Module 6 — JOINs | 7 | /7 |
| Module 7 — Aggregates | 6 | /6 |
| Module 8 — Subqueries & CTEs | 6 | /6 |
| Module 9 — UPDATE & DELETE | 5 | /5 |
| Module 10 — Indexes | 5 | /5 |
| Module 11 — Views | 3 | /3 |
| Module 12 — Transactions | 3 | /3 |
| Module 13 — Functions | 2 | /2 |
| Module 14 — Triggers | 2 | /2 |
| Module 15 — JSONB | 4 | /4 |
| Module 16 — Window Functions | 4 | /4 |
| Module 17 — Advanced Queries | 5 | /5 |
| Module 18 — ALTER Table | 4 | /4 |
| Module 19 — User Management | 2 | /2 |
| Module 20 — Backup & Cleanup | 4 | /4 |
| **Final Boss** | 3 | /3 |
| **TOTAL** | **94** | **/94** |

---

> 🐘 **You made it!** If you completed all 94 exercises, you've written real PostgreSQL queries from scratch — not just read about them. You now have a fully functioning e-commerce database with tables, relationships, data, indexes, views, functions, triggers, and more. That's HERO level! 🏆

---

*Practice makes permanent. Keep building!*
