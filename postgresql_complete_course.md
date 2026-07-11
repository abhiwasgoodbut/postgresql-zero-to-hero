# 🐘 PostgreSQL — From Zero to Hero (Complete Course Guide)

> **Audience**: Developers familiar with MongoDB who want to master PostgreSQL from scratch.
> **Prerequisites**: Basic programming knowledge, familiarity with databases (MongoDB), command-line basics.
> **Estimated Duration**: 8–12 weeks (self-paced)

---

## 📑 Table of Contents

1. [Module 1 — What is PostgreSQL & Why Learn It?](#module-1--what-is-postgresql--why-learn-it)
2. [Module 2 — Installation & Setup](#module-2--installation--setup)
3. [Module 3 — Your First Steps with psql & pgAdmin](#module-3--your-first-steps-with-psql--pgadmin)
4. [Module 4 — SQL Fundamentals](#module-4--sql-fundamentals)
5. [Module 5 — Data Types in PostgreSQL](#module-5--data-types-in-postgresql)
6. [Module 6 — Table Design & Constraints](#module-6--table-design--constraints)
7. [Module 7 — CRUD Operations Deep Dive](#module-7--crud-operations-deep-dive)
8. [Module 8 — Filtering, Sorting & Pagination](#module-8--filtering-sorting--pagination)
9. [Module 9 — Joins](#module-9--joins)
10. [Module 10 — Aggregate Functions & GROUP BY](#module-10--aggregate-functions--group-by)
11. [Module 11 — Subqueries & CTEs](#module-11--subqueries--ctes)
12. [Module 12 — Indexes & Query Performance](#module-12--indexes--query-performance)
13. [Module 13 — Views & Materialized Views](#module-13--views--materialized-views)
14. [Module 14 — Transactions & ACID](#module-14--transactions--acid)
15. [Module 15 — Functions & Stored Procedures](#module-15--functions--stored-procedures)
16. [Module 16 — Triggers & Event-Driven Logic](#module-16--triggers--event-driven-logic)
17. [Module 17 — JSON/JSONB](#module-17--jsonjsonb)
18. [Module 18 — User Management, Roles & Permissions](#module-18--user-management-roles--permissions)
19. [Module 19 — Backup, Restore & Maintenance](#module-19--backup-restore--maintenance)
20. [Module 20 — Advanced Topics](#module-20--advanced-topics)
21. [Module 21 — PostgreSQL with Node.js](#module-21--postgresql-with-nodejs)
22. [Module 22 — ORMs](#module-22--orms)
23. [Module 23 — MongoDB vs PostgreSQL Cheat Sheet](#module-23--mongodb-vs-postgresql-cheat-sheet)
24. [Module 24 — Real-World Project Ideas](#module-24--real-world-project-ideas)
25. [Module 25 — Resources & What's Next](#module-25--resources--whats-next)

---

<a id="module-1--what-is-postgresql--why-learn-it"></a>

## Module 1 — What is PostgreSQL & Why Learn It?

### 1.1 What is PostgreSQL?

PostgreSQL (often called **Postgres**) is a free, open-source **relational database management system (RDBMS)**. It stores data in **tables** (rows and columns) rather than documents (like MongoDB).

- First released in **1996** (evolved from the POSTGRES project at UC Berkeley, started in 1986).
- Known for being the **most advanced open-source relational database**.
- Used by companies like **Apple, Instagram, Spotify, Netflix, Uber, Reddit, and NASA**.

### 1.2 Relational vs Document (PostgreSQL vs MongoDB)

| Aspect | MongoDB (What You Know) | PostgreSQL (What You'll Learn) |
|---|---|---|
| **Data Model** | Documents (JSON/BSON) in collections | Rows in tables with fixed schemas |
| **Schema** | Schema-less / flexible | Schema-enforced (structured) |
| **Relationships** | Embedded docs or manual refs | Foreign keys & JOIN operations |
| **Query Language** | MongoDB Query Language (MQL) | SQL (Structured Query Language) |
| **Transactions** | Supported (since 4.0) | Battle-tested ACID compliance since day 1 |
| **Scaling** | Horizontal (sharding) | Vertical primarily; horizontal via extensions (Citus) |
| **Best For** | Rapid prototyping, flexible schemas, real-time analytics | Complex queries, data integrity, financial systems, reporting |

### 1.3 Why Learn PostgreSQL?

1. **Industry Standard**: Most companies use relational databases. PostgreSQL is the #1 most loved DB (Stack Overflow surveys).
2. **SQL is Universal**: SQL knowledge transfers to MySQL, SQLite, SQL Server, Oracle, etc.
3. **Data Integrity**: Enforced schemas prevent bad data from entering your system.
4. **Complex Queries**: JOINs, window functions, CTEs — things that are painful in MongoDB are natural in SQL.
5. **JSON Support**: PostgreSQL has excellent JSONB support, so you get the best of both worlds.
6. **Career Growth**: Backend, data engineering, and full-stack roles almost always require SQL.

### 1.4 Key Terminology Translation

| MongoDB Term | PostgreSQL Equivalent |
|---|---|
| Database | Database |
| Collection | Table |
| Document | Row (or Record/Tuple) |
| Field | Column (or Attribute) |
| `_id` | Primary Key (usually `id`) |
| Embedded Document | Related table + Foreign Key |
| `$lookup` | JOIN |
| Index | Index (same concept!) |
| Aggregation Pipeline | SQL queries with GROUP BY, HAVING, window functions |
| Mongoose (ODM) | Prisma / Sequelize / Drizzle (ORM) |

---

<a id="module-2--installation--setup"></a>

## Module 2 — Installation & Setup

### 2.1 Installing PostgreSQL on Windows

#### Method 1: Official Installer (Recommended for Beginners)

1. Go to [https://www.postgresql.org/download/windows/](https://www.postgresql.org/download/windows/)
2. Click **"Download the installer"** (provided by EDB/EnterpriseDB)
3. Download the latest version (e.g., PostgreSQL 16 or 17)
4. Run the installer:
   - **Installation Directory**: Keep default (`C:\Program Files\PostgreSQL\17`)
   - **Components**: Select ALL:
     - ✅ PostgreSQL Server
     - ✅ pgAdmin 4 (GUI tool — like MongoDB Compass)
     - ✅ Stack Builder (optional extras)
     - ✅ Command Line Tools
   - **Data Directory**: Keep default
   - **Password**: Set a **superuser password** for the `postgres` user. **REMEMBER THIS PASSWORD!**
   - **Port**: Keep default `5432`
   - **Locale**: Keep default
5. Click through and finish installation.

#### Method 2: Using Chocolatey (Package Manager)

```powershell
# Install Chocolatey first if you don't have it
# Then:
choco install postgresql --params '/Password:yourpassword /Port:5432'
```

#### Method 3: Using Docker (If You Prefer Containers)

```bash
# Pull the official PostgreSQL image
docker pull postgres:latest

# Run a PostgreSQL container
docker run --name my-postgres \
  -e POSTGRES_PASSWORD=mysecretpassword \
  -e POSTGRES_USER=myuser \
  -e POSTGRES_DB=mydb \
  -p 5432:5432 \
  -d postgres:latest
```

### 2.2 Verify Installation

Open **PowerShell** or **Command Prompt** and run:

```powershell
psql --version
```

Expected output:
```
psql (PostgreSQL) 17.x
```

> **Note**: If `psql` is not recognized, add PostgreSQL's `bin` directory to your system PATH:
> `C:\Program Files\PostgreSQL\17\bin`

### 2.3 Installing on macOS

```bash
# Using Homebrew (recommended)
brew install postgresql@17

# Start the service
brew services start postgresql@17

# Verify
psql --version
```

### 2.4 Installing on Linux (Ubuntu/Debian)

```bash
# Update package list
sudo apt update

# Install PostgreSQL
sudo apt install postgresql postgresql-contrib

# Check status
sudo systemctl status postgresql

# Start if not running
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Verify
psql --version
```

### 2.5 Understanding PostgreSQL Architecture (Quick Overview)

```
┌──────────────────────────────────────────┐
│              PostgreSQL Server            │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐  │
│  │  DB: app │  │ DB: test│  │DB:postgres│ │
│  │ ┌─────┐ │  │         │  │(default) │  │
│  │ │Table│ │  │         │  │          │  │
│  │ │users│ │  │         │  │          │  │
│  │ └─────┘ │  │         │  │          │  │
│  │ ┌─────┐ │  │         │  │          │  │
│  │ │Table│ │  │         │  │          │  │
│  │ │posts│ │  │         │  │          │  │
│  │ └─────┘ │  │         │  │          │  │
│  └─────────┘  └─────────┘  └─────────┘  │
│                                          │
│  Listens on port 5432                    │
└──────────────────────────────────────────┘
```

**Key difference from MongoDB**: In MongoDB, you connect to a server and switch databases. PostgreSQL works the same way, but each database contains **schemas** (like namespaces), and each schema contains **tables**.

```
Server → Database → Schema → Table → Columns & Rows
```

The default schema is called `public`.

---

<a id="module-3--your-first-steps-with-psql--pgadmin"></a>

## Module 3 — Your First Steps with psql & pgAdmin

### 3.1 Connecting via psql (Command Line)

`psql` is PostgreSQL's interactive terminal — think of it like the `mongosh` shell.

```powershell
# Connect as the default superuser 'postgres'
psql -U postgres

# You'll be prompted for the password you set during installation
```

Once connected, you'll see:
```
postgres=#
```

The `#` means you're a superuser. Regular users see `>`.

### 3.2 Essential psql Meta-Commands

These start with a backslash (`\`) and are psql-specific (not SQL):

| Command | Description | MongoDB Equivalent |
|---|---|---|
| `\l` | List all databases | `show dbs` |
| `\c dbname` | Connect to a database | `use dbname` |
| `\dt` | List all tables in current DB | `show collections` |
| `\d tablename` | Describe a table (columns, types) | — (no direct equivalent) |
| `\d+ tablename` | Detailed table info | — |
| `\du` | List all users/roles | `db.getUsers()` |
| `\dn` | List schemas | — |
| `\di` | List indexes | `db.collection.getIndexes()` |
| `\df` | List functions | — |
| `\x` | Toggle expanded display | — |
| `\timing` | Toggle query execution timing | `.explain("executionStats")` |
| `\q` | Quit psql | `exit` |
| `\?` | Help for psql commands | `help` |
| `\h COMMAND` | Help for SQL commands (e.g., `\h SELECT`) | — |
| `\i filename` | Execute SQL from a file | `load("file.js")` |

### 3.3 Your First Commands

```sql
-- Create a new database
CREATE DATABASE learning_pg;

-- Connect to it
\c learning_pg

-- You should see:
-- You are now connected to database "learning_pg" as user "postgres".

-- Check current database and user
SELECT current_database();
SELECT current_user;

-- Check PostgreSQL version
SELECT version();
```

### 3.4 Using pgAdmin 4 (GUI Tool)

pgAdmin is like **MongoDB Compass** — a visual tool for managing PostgreSQL.

1. Open **pgAdmin 4** from Start Menu
2. It opens in your browser (usually `http://127.0.0.1:xxxx/browser/`)
3. First time: Set a **master password** for pgAdmin itself
4. In the left sidebar, expand: **Servers → PostgreSQL 17**
5. Enter your PostgreSQL password when prompted
6. You can now:
   - Browse databases, tables, columns
   - Run SQL queries in the **Query Tool** (right-click a database → Query Tool)
   - View table data visually
   - Create tables with a GUI
   - Monitor server activity

### 3.5 Other GUI Tools Worth Knowing

| Tool | Description | Cost |
|---|---|---|
| **pgAdmin 4** | Official PostgreSQL GUI | Free |
| **DBeaver** | Universal database tool (supports many DBs) | Free (Community) |
| **TablePlus** | Sleek, modern database GUI | Free tier / Paid |
| **DataGrip** | JetBrains IDE for databases | Paid (free for students) |
| **Beekeeper Studio** | Modern, minimal SQL editor | Free (Community) |

---

<a id="module-4--sql-fundamentals"></a>

## Module 4 — SQL Fundamentals

### 4.1 What is SQL?

SQL (**Structured Query Language**) is the standard language for communicating with relational databases. Unlike MongoDB's query objects, SQL uses a **declarative, English-like syntax**.

**MongoDB (what you know):**
```javascript
db.users.find({ age: { $gte: 18 } }, { name: 1, age: 1 })
```

**PostgreSQL (what you'll learn):**
```sql
SELECT name, age FROM users WHERE age >= 18;
```

### 4.2 SQL Statement Categories

| Category | Name | Commands | Purpose |
|---|---|---|---|
| **DDL** | Data Definition Language | `CREATE`, `ALTER`, `DROP`, `TRUNCATE` | Define/modify database structure |
| **DML** | Data Manipulation Language | `SELECT`, `INSERT`, `UPDATE`, `DELETE` | Manipulate data |
| **DCL** | Data Control Language | `GRANT`, `REVOKE` | Control access/permissions |
| **TCL** | Transaction Control Language | `BEGIN`, `COMMIT`, `ROLLBACK`, `SAVEPOINT` | Manage transactions |

### 4.3 SQL Syntax Rules

```sql
-- 1. SQL statements end with a semicolon ;
SELECT * FROM users;

-- 2. SQL is case-INSENSITIVE for keywords (but convention is UPPERCASE)
select * from users;   -- works
SELECT * FROM users;   -- preferred style

-- 3. String values use SINGLE quotes (not double)
SELECT * FROM users WHERE name = 'John';   -- ✅ correct
-- SELECT * FROM users WHERE name = "John"; -- ❌ wrong! Double quotes are for identifiers

-- 4. Double quotes are for identifiers (column/table names with special chars)
SELECT "First Name" FROM users;  -- column name with a space

-- 5. Comments
-- This is a single-line comment
/* This is a
   multi-line comment */

-- 6. SQL ignores extra whitespace — format freely for readability
SELECT
    name,
    age,
    email
FROM
    users
WHERE
    age >= 18
ORDER BY
    name;
```

### 4.4 Creating Your First Database & Table

```sql
-- Step 1: Create a database
CREATE DATABASE myapp;

-- Step 2: Connect to it
\c myapp

-- Step 3: Create a table
CREATE TABLE users (
    id          SERIAL PRIMARY KEY,         -- auto-incrementing integer ID
    name        VARCHAR(100) NOT NULL,       -- variable-length string, max 100 chars
    email       VARCHAR(255) UNIQUE NOT NULL,-- must be unique and not null
    age         INTEGER,                     -- whole number
    is_active   BOOLEAN DEFAULT true,        -- true/false, defaults to true
    created_at  TIMESTAMP DEFAULT NOW()      -- timestamp, defaults to current time
);

-- Step 4: Verify
\d users
```

**MongoDB comparison:**
```javascript
// MongoDB — no explicit schema needed (handled by Mongoose if used)
// In Mongoose:
const userSchema = new Schema({
  name:      { type: String, required: true },
  email:     { type: String, unique: true, required: true },
  age:       Number,
  isActive:  { type: Boolean, default: true },
  createdAt: { type: Date, default: Date.now }
});
```

### 4.5 Naming Conventions

| Convention | Example | Notes |
|---|---|---|
| Table names | `users`, `blog_posts` | Plural, snake_case |
| Column names | `first_name`, `created_at` | snake_case |
| Primary keys | `id` or `user_id` | Simple and consistent |
| Foreign keys | `user_id`, `post_id` | `referenced_table_singular_id` |
| Indexes | `idx_users_email` | `idx_table_column` |
| Constraints | `chk_users_age`, `uq_users_email` | Prefixed with type |

---

<a id="module-5--data-types-in-postgresql"></a>

## Module 5 — Data Types in PostgreSQL

PostgreSQL has a rich type system — far more than MongoDB.

### 5.1 Numeric Types

| Type | Size | Range | Use Case |
|---|---|---|---|
| `SMALLINT` | 2 bytes | -32,768 to 32,767 | Small numbers (age, quantity) |
| `INTEGER` (or `INT`) | 4 bytes | -2,147,483,648 to 2,147,483,647 | Most common integer type |
| `BIGINT` | 8 bytes | -9.2 quintillion to 9.2 quintillion | Large numbers (social media IDs) |
| `DECIMAL(p,s)` / `NUMERIC(p,s)` | Variable | Up to 131,072 digits before decimal, 16,383 after | Exact precision (money!) |
| `REAL` | 4 bytes | 6 decimal digits precision | Approximate floating point |
| `DOUBLE PRECISION` | 8 bytes | 15 decimal digits precision | Scientific calculations |
| `SERIAL` | 4 bytes | Auto-incrementing 1 to 2,147,483,647 | Auto-increment primary keys |
| `BIGSERIAL` | 8 bytes | Auto-incrementing 1 to 9.2 quintillion | Large auto-increment PKs |

```sql
-- Examples
CREATE TABLE products (
    id          SERIAL PRIMARY KEY,
    quantity    SMALLINT NOT NULL DEFAULT 0,
    price       DECIMAL(10, 2) NOT NULL,       -- e.g., 99999999.99
    weight      REAL,
    views       BIGINT DEFAULT 0
);
```

> **⚠️ Important**: NEVER use `REAL` or `DOUBLE PRECISION` for money. Use `DECIMAL` or `NUMERIC` for exact precision, or store amounts as integers (cents).

### 5.2 String / Text Types

| Type | Description | Use Case |
|---|---|---|
| `CHAR(n)` | Fixed-length string, padded with spaces | Country codes (`CHAR(2)`) |
| `VARCHAR(n)` | Variable-length string with limit | Names, emails, titles |
| `TEXT` | Unlimited-length string | Blog content, descriptions |

```sql
CREATE TABLE articles (
    id         SERIAL PRIMARY KEY,
    title      VARCHAR(200) NOT NULL,
    slug       VARCHAR(200) UNIQUE NOT NULL,
    content    TEXT NOT NULL,
    country    CHAR(2) DEFAULT 'US'
);
```

> **Tip**: In PostgreSQL, `TEXT` and `VARCHAR` have almost identical performance. Use `VARCHAR(n)` when you want to enforce a max length, `TEXT` when you don't care.

### 5.3 Boolean

| Type | Valid Values |
|---|---|
| `BOOLEAN` | `TRUE`, `FALSE`, `NULL` |

```sql
-- All of these work for TRUE:
-- TRUE, 'yes', 'y', 'on', '1', 't', 'true'

-- All of these work for FALSE:
-- FALSE, 'no', 'n', 'off', '0', 'f', 'false'

CREATE TABLE settings (
    id              SERIAL PRIMARY KEY,
    dark_mode       BOOLEAN DEFAULT FALSE,
    notifications   BOOLEAN DEFAULT TRUE
);
```

### 5.4 Date & Time Types

| Type | Description | Example |
|---|---|---|
| `DATE` | Date only (no time) | `2025-07-02` |
| `TIME` | Time only (no date) | `14:30:00` |
| `TIMESTAMP` | Date + Time (no timezone) | `2025-07-02 14:30:00` |
| `TIMESTAMPTZ` | Date + Time + Timezone (**recommended**) | `2025-07-02 14:30:00+05:30` |
| `INTERVAL` | Duration / time span | `1 year 2 months 3 days` |

```sql
CREATE TABLE events (
    id          SERIAL PRIMARY KEY,
    title       VARCHAR(200),
    event_date  DATE NOT NULL,
    start_time  TIME,
    created_at  TIMESTAMPTZ DEFAULT NOW(),
    duration    INTERVAL
);

-- Insert examples
INSERT INTO events (title, event_date, start_time, duration)
VALUES ('Conference', '2025-12-15', '09:00:00', '3 hours');

-- Date arithmetic
SELECT NOW();                              -- current timestamp with timezone
SELECT NOW() + INTERVAL '7 days';          -- 7 days from now
SELECT NOW() - INTERVAL '1 month';         -- 1 month ago
SELECT AGE(NOW(), '1995-06-15');           -- time elapsed since a date
SELECT EXTRACT(YEAR FROM NOW());           -- extract year
SELECT DATE_TRUNC('month', NOW());         -- truncate to start of month
```

> **MongoDB comparison**: In MongoDB, you use `new Date()` and `ISODate()`. PostgreSQL's `TIMESTAMPTZ` is equivalent but more powerful with built-in date arithmetic.

### 5.5 UUID Type

```sql
-- Enable UUID generation (PostgreSQL 13+, gen_random_uuid is built-in)
CREATE TABLE sessions (
    id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id     INTEGER NOT NULL,
    token       TEXT NOT NULL,
    created_at  TIMESTAMPTZ DEFAULT NOW()
);

-- Insert (auto-generates UUID)
INSERT INTO sessions (user_id, token) VALUES (1, 'abc123');

-- Result: id = 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11' (random)
```

> **MongoDB comparison**: This is like MongoDB's `ObjectId`, but it's a standard UUID v4 format.

### 5.6 JSON & JSONB Types

| Type | Description | Use Case |
|---|---|---|
| `JSON` | Stores JSON as plain text | Rarely used |
| `JSONB` | Stores JSON in binary format (indexed, faster) | **Always prefer this** |

```sql
CREATE TABLE profiles (
    id          SERIAL PRIMARY KEY,
    user_id     INTEGER NOT NULL,
    metadata    JSONB DEFAULT '{}'::jsonb,
    preferences JSONB
);

-- Insert JSON data
INSERT INTO profiles (user_id, metadata, preferences) VALUES
(1,
 '{"theme": "dark", "lang": "en", "notifications": {"email": true, "sms": false}}',
 '{"font_size": 14, "compact_mode": true}'
);

-- Query JSON fields (covered in detail in Module 17)
SELECT metadata->>'theme' AS theme FROM profiles;    -- 'dark'
SELECT metadata->'notifications'->>'email' FROM profiles;  -- 'true'
```

> **This is huge!** PostgreSQL can work with JSON natively, giving you the flexibility of MongoDB when you need it.

### 5.7 Array Type

PostgreSQL supports arrays — something SQL databases typically don't have!

```sql
CREATE TABLE posts (
    id      SERIAL PRIMARY KEY,
    title   VARCHAR(200),
    tags    TEXT[] DEFAULT '{}',          -- array of text
    scores  INTEGER[]                     -- array of integers
);

-- Insert with arrays
INSERT INTO posts (title, tags, scores) VALUES
('My Post', ARRAY['javascript', 'nodejs', 'postgresql'], ARRAY[95, 87, 92]);

-- Alternative syntax
INSERT INTO posts (title, tags) VALUES
('Another Post', '{"python", "django"}');

-- Query arrays
SELECT * FROM posts WHERE 'nodejs' = ANY(tags);           -- contains element
SELECT * FROM posts WHERE tags @> ARRAY['javascript'];     -- contains subset
SELECT array_length(tags, 1) FROM posts;                   -- array length
SELECT tags[1] FROM posts;                                 -- first element (1-indexed!)
```

### 5.8 Enum Type

```sql
-- Create a custom enum type
CREATE TYPE mood AS ENUM ('happy', 'sad', 'neutral', 'excited');
CREATE TYPE user_role AS ENUM ('admin', 'moderator', 'user', 'guest');

CREATE TABLE members (
    id      SERIAL PRIMARY KEY,
    name    VARCHAR(100),
    role    user_role DEFAULT 'user',
    mood    mood
);

INSERT INTO members (name, role, mood) VALUES ('Alice', 'admin', 'happy');
```

### 5.9 Other Useful Types

| Type | Description |
|---|---|
| `BYTEA` | Binary data (like files, images) |
| `INET` | IPv4 or IPv6 address |
| `CIDR` | Network address |
| `MACADDR` | MAC address |
| `MONEY` | Currency amount (locale-aware) |
| `POINT`, `LINE`, `CIRCLE`, `POLYGON` | Geometric types |
| `TSVECTOR`, `TSQUERY` | Full-text search types |
| `INT4RANGE`, `DATERANGE`, etc. | Range types |

---

<a id="module-6--table-design--constraints"></a>

## Module 6 — Table Design & Constraints

### 6.1 What Are Constraints?

Constraints are rules enforced at the **database level** to ensure data integrity. In MongoDB, you rely on application-level validation (Mongoose schemas). In PostgreSQL, the database itself rejects invalid data.

### 6.2 Constraint Types

#### PRIMARY KEY

Uniquely identifies each row. Every table should have one.

```sql
-- Single column primary key
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

-- Composite primary key (multiple columns)
CREATE TABLE enrollments (
    student_id INTEGER,
    course_id  INTEGER,
    enrolled_at TIMESTAMPTZ DEFAULT NOW(),
    PRIMARY KEY (student_id, course_id)
);
```

#### NOT NULL

Column must always have a value.

```sql
CREATE TABLE products (
    id      SERIAL PRIMARY KEY,
    name    VARCHAR(200) NOT NULL,      -- cannot be NULL
    price   DECIMAL(10,2) NOT NULL,
    description TEXT                     -- can be NULL (default)
);
```

#### UNIQUE

No two rows can have the same value in this column.

```sql
CREATE TABLE users (
    id      SERIAL PRIMARY KEY,
    email   VARCHAR(255) UNIQUE NOT NULL,        -- unique single column
    phone   VARCHAR(20) UNIQUE                    -- unique but nullable
);

-- Multi-column unique constraint
CREATE TABLE follows (
    id           SERIAL PRIMARY KEY,
    follower_id  INTEGER NOT NULL,
    following_id INTEGER NOT NULL,
    UNIQUE(follower_id, following_id)  -- same pair can't follow twice
);
```

#### DEFAULT

Set a default value when none is provided.

```sql
CREATE TABLE orders (
    id          SERIAL PRIMARY KEY,
    status      VARCHAR(20) DEFAULT 'pending',
    quantity    INTEGER DEFAULT 1,
    is_paid     BOOLEAN DEFAULT FALSE,
    created_at  TIMESTAMPTZ DEFAULT NOW()
);
```

#### CHECK

Custom validation rules.

```sql
CREATE TABLE employees (
    id      SERIAL PRIMARY KEY,
    name    VARCHAR(100) NOT NULL,
    age     INTEGER CHECK (age >= 18 AND age <= 120),
    salary  DECIMAL(10,2) CHECK (salary > 0),
    email   VARCHAR(255) CHECK (email LIKE '%@%.%')
);

-- Named constraints (better error messages)
CREATE TABLE products (
    id      SERIAL PRIMARY KEY,
    name    VARCHAR(200) NOT NULL,
    price   DECIMAL(10,2) CONSTRAINT positive_price CHECK (price >= 0),
    stock   INTEGER CONSTRAINT non_negative_stock CHECK (stock >= 0)
);
```

#### FOREIGN KEY (Relationships!)

This is the **biggest difference from MongoDB**. Foreign keys create enforced links between tables.

```sql
-- Parent table
CREATE TABLE authors (
    id      SERIAL PRIMARY KEY,
    name    VARCHAR(100) NOT NULL,
    email   VARCHAR(255) UNIQUE NOT NULL
);

-- Child table with foreign key
CREATE TABLE books (
    id          SERIAL PRIMARY KEY,
    title       VARCHAR(200) NOT NULL,
    author_id   INTEGER NOT NULL,
    published   DATE,
    FOREIGN KEY (author_id) REFERENCES authors(id)
        ON DELETE CASCADE        -- if author is deleted, delete their books too
        ON UPDATE CASCADE        -- if author's id changes, update reference
);
```

**Foreign Key Actions:**

| Action | ON DELETE Behavior | ON UPDATE Behavior |
|---|---|---|
| `CASCADE` | Delete child rows too | Update child references |
| `SET NULL` | Set foreign key to NULL | Set foreign key to NULL |
| `SET DEFAULT` | Set to default value | Set to default value |
| `RESTRICT` | Prevent deletion if children exist | Prevent update |
| `NO ACTION` (default) | Same as RESTRICT (checked at end of statement) | Same as RESTRICT |

```sql
-- MongoDB comparison: In MongoDB, you'd do this manually
// MongoDB way (manual reference, no enforcement):
// { title: "My Book", authorId: ObjectId("...") }
// You have to manually ensure the authorId exists!

-- PostgreSQL way (database enforces the relationship):
-- INSERT INTO books (title, author_id) VALUES ('My Book', 999);
-- ERROR: insert or update on table "books" violates foreign key constraint
-- Detail: Key (author_id)=(999) is not present in table "authors".
```

### 6.3 Relationship Types

#### One-to-Many (Most Common)

One author → many books. One user → many posts.

```sql
CREATE TABLE users (
    id      SERIAL PRIMARY KEY,
    name    VARCHAR(100) NOT NULL
);

CREATE TABLE posts (
    id          SERIAL PRIMARY KEY,
    title       VARCHAR(200) NOT NULL,
    body        TEXT,
    user_id     INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    created_at  TIMESTAMPTZ DEFAULT NOW()
);
```

#### One-to-One

One user → one profile.

```sql
CREATE TABLE users (
    id      SERIAL PRIMARY KEY,
    email   VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE profiles (
    id          SERIAL PRIMARY KEY,
    user_id     INTEGER UNIQUE NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    bio         TEXT,
    avatar_url  VARCHAR(500)
);
```

The `UNIQUE` constraint on `user_id` ensures one-to-one.

#### Many-to-Many

Students ↔ Courses. Users ↔ Roles. Posts ↔ Tags.

Requires a **junction table** (also called join table, bridge table, or pivot table):

```sql
CREATE TABLE students (
    id      SERIAL PRIMARY KEY,
    name    VARCHAR(100) NOT NULL
);

CREATE TABLE courses (
    id      SERIAL PRIMARY KEY,
    title   VARCHAR(200) NOT NULL
);

-- Junction table
CREATE TABLE enrollments (
    student_id  INTEGER REFERENCES students(id) ON DELETE CASCADE,
    course_id   INTEGER REFERENCES courses(id) ON DELETE CASCADE,
    enrolled_at TIMESTAMPTZ DEFAULT NOW(),
    grade       CHAR(2),
    PRIMARY KEY (student_id, course_id)   -- composite primary key prevents duplicates
);
```

> **MongoDB comparison**: In MongoDB, you might use arrays of ObjectIds or embedded documents. In PostgreSQL, you always use a junction table for many-to-many relationships.

### 6.4 Altering Tables

```sql
-- Add a column
ALTER TABLE users ADD COLUMN phone VARCHAR(20);

-- Remove a column
ALTER TABLE users DROP COLUMN phone;

-- Rename a column
ALTER TABLE users RENAME COLUMN name TO full_name;

-- Change column type
ALTER TABLE users ALTER COLUMN full_name TYPE TEXT;

-- Add a constraint
ALTER TABLE users ADD CONSTRAINT uq_email UNIQUE (email);

-- Remove a constraint
ALTER TABLE users DROP CONSTRAINT uq_email;

-- Set/remove default
ALTER TABLE users ALTER COLUMN is_active SET DEFAULT true;
ALTER TABLE users ALTER COLUMN is_active DROP DEFAULT;

-- Set/remove NOT NULL
ALTER TABLE users ALTER COLUMN email SET NOT NULL;
ALTER TABLE users ALTER COLUMN email DROP NOT NULL;

-- Rename a table
ALTER TABLE users RENAME TO members;

-- Delete a table (CAREFUL!)
DROP TABLE IF EXISTS members;

-- Delete all rows but keep the table structure
TRUNCATE TABLE users;
-- TRUNCATE is much faster than DELETE for clearing all rows
```

---

<a id="module-7--crud-operations-deep-dive"></a>

## Module 7 — CRUD Operations Deep Dive

### 7.1 INSERT (Create)

```sql
-- Insert a single row
INSERT INTO users (name, email, age)
VALUES ('Alice Johnson', 'alice@example.com', 28);

-- Insert multiple rows
INSERT INTO users (name, email, age) VALUES
    ('Bob Smith', 'bob@example.com', 34),
    ('Charlie Brown', 'charlie@example.com', 22),
    ('Diana Prince', 'diana@example.com', 30);

-- Insert and return the created row
INSERT INTO users (name, email, age)
VALUES ('Eve Wilson', 'eve@example.com', 26)
RETURNING *;          -- returns all columns of the inserted row

-- Insert with RETURNING specific columns
INSERT INTO users (name, email)
VALUES ('Frank Lee', 'frank@example.com')
RETURNING id, name;   -- only return id and name

-- Insert from another table
INSERT INTO archived_users (name, email, age)
SELECT name, email, age FROM users WHERE is_active = FALSE;

-- Upsert (INSERT or UPDATE on conflict) — like MongoDB's upsert!
INSERT INTO users (email, name, age)
VALUES ('alice@example.com', 'Alice J.', 29)
ON CONFLICT (email)
DO UPDATE SET name = EXCLUDED.name, age = EXCLUDED.age;

-- Upsert — do nothing on conflict
INSERT INTO users (email, name)
VALUES ('alice@example.com', 'Alice')
ON CONFLICT (email) DO NOTHING;
```

> **MongoDB comparison:**
> - `insertOne()` → `INSERT INTO ... VALUES (...)`
> - `insertMany()` → `INSERT INTO ... VALUES (...), (...), (...)`
> - `updateOne({ ... }, { ... }, { upsert: true })` → `INSERT ... ON CONFLICT ... DO UPDATE`

### 7.2 SELECT (Read)

```sql
-- Select all columns, all rows
SELECT * FROM users;

-- Select specific columns
SELECT name, email FROM users;

-- Select with alias
SELECT name AS full_name, email AS contact_email FROM users;

-- Select distinct values (no duplicates)
SELECT DISTINCT age FROM users;

-- Select with expressions
SELECT
    name,
    age,
    age * 365 AS approximate_days_alive,
    UPPER(name) AS name_uppercase,
    LENGTH(email) AS email_length
FROM users;
```

### 7.3 UPDATE

```sql
-- Update specific rows
UPDATE users
SET age = 29, name = 'Alice J.'
WHERE email = 'alice@example.com';

-- Update with expressions
UPDATE products
SET price = price * 1.10         -- 10% price increase
WHERE category = 'electronics';

-- Update and return updated rows
UPDATE users
SET is_active = FALSE
WHERE last_login < NOW() - INTERVAL '1 year'
RETURNING id, name, email;

-- Update all rows (CAREFUL — no WHERE clause!)
UPDATE users SET is_active = TRUE;

-- Update using values from another table
UPDATE orders
SET status = 'cancelled'
WHERE user_id IN (
    SELECT id FROM users WHERE is_banned = TRUE
);
```

> **MongoDB comparison:**
> - `updateOne({ email: "alice@..." }, { $set: { age: 29 } })` → `UPDATE users SET age = 29 WHERE email = 'alice@...'`
> - `updateMany({ ... }, { $inc: { price: 10 } })` → `UPDATE products SET price = price + 10 WHERE ...`

### 7.4 DELETE

```sql
-- Delete specific rows
DELETE FROM users WHERE id = 5;

-- Delete with condition
DELETE FROM users
WHERE is_active = FALSE
AND last_login < NOW() - INTERVAL '2 years';

-- Delete and return deleted rows
DELETE FROM users WHERE is_banned = TRUE
RETURNING *;

-- Delete all rows (use TRUNCATE instead for better performance)
DELETE FROM users;        -- slow, logged row-by-row
TRUNCATE TABLE users;     -- fast, resets the table
```

> **MongoDB comparison:**
> - `deleteOne({ _id: ObjectId("...") })` → `DELETE FROM users WHERE id = 5`
> - `deleteMany({ isActive: false })` → `DELETE FROM users WHERE is_active = FALSE`

---

<a id="module-8--filtering-sorting--pagination"></a>

## Module 8 — Filtering, Sorting & Pagination

### 8.1 WHERE Clause (Filtering)

```sql
-- Comparison operators
SELECT * FROM users WHERE age = 25;
SELECT * FROM users WHERE age != 25;       -- or <>
SELECT * FROM users WHERE age > 25;
SELECT * FROM users WHERE age >= 25;
SELECT * FROM users WHERE age < 25;
SELECT * FROM users WHERE age <= 25;

-- Logical operators
SELECT * FROM users WHERE age >= 18 AND age <= 65;
SELECT * FROM users WHERE role = 'admin' OR role = 'moderator';
SELECT * FROM users WHERE NOT is_banned;

-- IN (like MongoDB's $in)
SELECT * FROM users WHERE role IN ('admin', 'moderator', 'editor');
SELECT * FROM users WHERE id IN (1, 5, 10, 15);

-- NOT IN
SELECT * FROM users WHERE role NOT IN ('guest', 'banned');

-- BETWEEN (inclusive range)
SELECT * FROM users WHERE age BETWEEN 18 AND 30;
-- Same as: WHERE age >= 18 AND age <= 30

SELECT * FROM orders WHERE created_at BETWEEN '2025-01-01' AND '2025-12-31';

-- IS NULL / IS NOT NULL
SELECT * FROM users WHERE phone IS NULL;
SELECT * FROM users WHERE phone IS NOT NULL;
-- Note: You CANNOT use = NULL or != NULL. Always use IS NULL / IS NOT NULL.

-- LIKE (pattern matching)
SELECT * FROM users WHERE name LIKE 'A%';        -- starts with A
SELECT * FROM users WHERE name LIKE '%son';       -- ends with 'son'
SELECT * FROM users WHERE name LIKE '%ali%';      -- contains 'ali'
SELECT * FROM users WHERE name LIKE '_o%';        -- second char is 'o'
-- % = any number of characters, _ = exactly one character

-- ILIKE (case-insensitive LIKE — PostgreSQL specific!)
SELECT * FROM users WHERE name ILIKE '%alice%';   -- matches 'Alice', 'ALICE', 'aLiCe'

-- SIMILAR TO (regex-like)
SELECT * FROM users WHERE email SIMILAR TO '%@(gmail|yahoo)\.com';

-- POSIX Regular Expressions (PostgreSQL power feature!)
SELECT * FROM users WHERE name ~ '^[A-Z]';       -- starts with uppercase
SELECT * FROM users WHERE email ~* 'gmail';       -- case-insensitive regex
```

> **MongoDB comparison:**
> - `{ age: { $gte: 18, $lte: 30 } }` → `WHERE age BETWEEN 18 AND 30`
> - `{ role: { $in: ['admin', 'mod'] } }` → `WHERE role IN ('admin', 'mod')`
> - `{ name: /alice/i }` → `WHERE name ILIKE '%alice%'`
> - `{ phone: { $exists: true } }` → `WHERE phone IS NOT NULL`

### 8.2 ORDER BY (Sorting)

```sql
-- Sort ascending (default)
SELECT * FROM users ORDER BY name;
SELECT * FROM users ORDER BY name ASC;     -- explicit ascending

-- Sort descending
SELECT * FROM users ORDER BY created_at DESC;

-- Multiple sort columns
SELECT * FROM users ORDER BY role ASC, name ASC;

-- Sort by column position (not recommended but useful for quick queries)
SELECT name, age FROM users ORDER BY 2 DESC;  -- sort by 2nd column (age)

-- Sort with NULLs control
SELECT * FROM users ORDER BY age ASC NULLS FIRST;   -- NULLs at the start
SELECT * FROM users ORDER BY age DESC NULLS LAST;    -- NULLs at the end
```

### 8.3 LIMIT & OFFSET (Pagination)

```sql
-- Get first 10 rows
SELECT * FROM users ORDER BY id LIMIT 10;

-- Skip first 20, get next 10 (page 3 of 10-per-page)
SELECT * FROM users ORDER BY id LIMIT 10 OFFSET 20;

-- Pagination formula:
-- Page N with P items per page:
-- LIMIT P OFFSET (N - 1) * P

-- Page 1: LIMIT 10 OFFSET 0
-- Page 2: LIMIT 10 OFFSET 10
-- Page 3: LIMIT 10 OFFSET 20
```

> **MongoDB comparison:**
> - `.sort({ name: 1 })` → `ORDER BY name ASC`
> - `.limit(10)` → `LIMIT 10`
> - `.skip(20)` → `OFFSET 20`

> **⚠️ Performance Warning**: `OFFSET` is slow for large datasets because PostgreSQL must scan and discard all skipped rows. For large-scale pagination, use **cursor-based pagination** (also called keyset pagination):

```sql
-- Cursor-based pagination (much faster for large datasets)
-- Instead of OFFSET, use WHERE with the last seen value:

-- First page
SELECT * FROM users ORDER BY id LIMIT 10;

-- Next page (assuming last id on previous page was 10)
SELECT * FROM users WHERE id > 10 ORDER BY id LIMIT 10;

-- Next page (assuming last id was 20)
SELECT * FROM users WHERE id > 20 ORDER BY id LIMIT 10;
```

### 8.4 FETCH (SQL Standard Alternative to LIMIT)

```sql
-- These are equivalent:
SELECT * FROM users ORDER BY id LIMIT 10;
SELECT * FROM users ORDER BY id FETCH FIRST 10 ROWS ONLY;

-- With offset:
SELECT * FROM users ORDER BY id OFFSET 20 ROWS FETCH NEXT 10 ROWS ONLY;
```

---

<a id="module-9--joins"></a>

## Module 9 — Joins

### 9.1 Why Joins?

In MongoDB, you either:
- **Embed** related data in the same document (denormalization)
- Use `$lookup` in aggregation pipeline (slow, limited)

In PostgreSQL, data is **normalized** (split into separate tables), and you use **JOINs** to combine them. This is THE fundamental skill of relational databases.

### 9.2 Setup Example Data

```sql
-- Create tables
CREATE TABLE customers (
    id      SERIAL PRIMARY KEY,
    name    VARCHAR(100) NOT NULL,
    email   VARCHAR(255) UNIQUE NOT NULL,
    city    VARCHAR(100)
);

CREATE TABLE orders (
    id           SERIAL PRIMARY KEY,
    customer_id  INTEGER REFERENCES customers(id),
    product      VARCHAR(200) NOT NULL,
    amount       DECIMAL(10,2) NOT NULL,
    order_date   DATE DEFAULT CURRENT_DATE
);

-- Insert data
INSERT INTO customers (name, email, city) VALUES
    ('Alice', 'alice@mail.com', 'New York'),
    ('Bob', 'bob@mail.com', 'London'),
    ('Charlie', 'charlie@mail.com', 'Paris'),
    ('Diana', 'diana@mail.com', 'Tokyo');      -- Diana has no orders

INSERT INTO orders (customer_id, product, amount) VALUES
    (1, 'Laptop', 999.99),
    (1, 'Mouse', 29.99),
    (2, 'Keyboard', 79.99),
    (3, 'Monitor', 349.99),
    (NULL, 'USB Cable', 9.99);    -- Order with no customer (orphan)
```

### 9.3 INNER JOIN

Returns only rows that have matching values in **both** tables.

```sql
SELECT
    c.name AS customer_name,
    o.product,
    o.amount
FROM customers c
INNER JOIN orders o ON c.id = o.customer_id;
```

Result:
```
 customer_name | product  | amount
---------------+----------+--------
 Alice         | Laptop   | 999.99
 Alice         | Mouse    |  29.99
 Bob           | Keyboard |  79.99
 Charlie       | Monitor  | 349.99
```

Diana (no orders) and the USB Cable (no customer) are excluded.

### 9.4 LEFT JOIN (LEFT OUTER JOIN)

Returns ALL rows from the **left** table, and matching rows from the right. If no match, right side is NULL.

```sql
SELECT
    c.name AS customer_name,
    o.product,
    o.amount
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id;
```

Result:
```
 customer_name | product  | amount
---------------+----------+--------
 Alice         | Laptop   | 999.99
 Alice         | Mouse    |  29.99
 Bob           | Keyboard |  79.99
 Charlie       | Monitor  | 349.99
 Diana         | NULL     |   NULL    ← Diana included, no orders
```

### 9.5 RIGHT JOIN (RIGHT OUTER JOIN)

Returns ALL rows from the **right** table, and matching rows from the left.

```sql
SELECT
    c.name AS customer_name,
    o.product,
    o.amount
FROM customers c
RIGHT JOIN orders o ON c.id = o.customer_id;
```

Result:
```
 customer_name | product   | amount
---------------+-----------+--------
 Alice         | Laptop    | 999.99
 Alice         | Mouse     |  29.99
 Bob           | Keyboard  |  79.99
 Charlie       | Monitor   | 349.99
 NULL          | USB Cable |   9.99   ← Orphan order included
```

### 9.6 FULL OUTER JOIN

Returns ALL rows from **both** tables. NULLs where there's no match.

```sql
SELECT
    c.name AS customer_name,
    o.product,
    o.amount
FROM customers c
FULL OUTER JOIN orders o ON c.id = o.customer_id;
```

Result:
```
 customer_name | product   | amount
---------------+-----------+--------
 Alice         | Laptop    | 999.99
 Alice         | Mouse     |  29.99
 Bob           | Keyboard  |  79.99
 Charlie       | Monitor   | 349.99
 Diana         | NULL      |   NULL   ← No orders
 NULL          | USB Cable |   9.99   ← No customer
```

### 9.7 CROSS JOIN

Returns the **Cartesian product** — every combination of rows from both tables.

```sql
SELECT c.name, o.product
FROM customers c
CROSS JOIN orders o;
-- 4 customers × 5 orders = 20 rows
```

### 9.8 SELF JOIN

A table joined with itself. Useful for hierarchical data.

```sql
CREATE TABLE employees (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    manager_id  INTEGER REFERENCES employees(id)
);

INSERT INTO employees (name, manager_id) VALUES
    ('CEO', NULL),
    ('VP Engineering', 1),
    ('VP Sales', 1),
    ('Senior Dev', 2),
    ('Junior Dev', 4);

-- Find each employee and their manager
SELECT
    e.name AS employee,
    m.name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id;
```

Result:
```
   employee     |    manager
----------------+----------------
 CEO            | NULL
 VP Engineering | CEO
 VP Sales       | CEO
 Senior Dev     | VP Engineering
 Junior Dev     | Senior Dev
```

### 9.9 Multiple Joins

```sql
-- Three-table join
CREATE TABLE categories (
    id      SERIAL PRIMARY KEY,
    name    VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(200) NOT NULL,
    category_id INTEGER REFERENCES categories(id),
    price       DECIMAL(10,2)
);

CREATE TABLE reviews (
    id          SERIAL PRIMARY KEY,
    product_id  INTEGER REFERENCES products(id),
    user_id     INTEGER REFERENCES users(id),
    rating      SMALLINT CHECK (rating BETWEEN 1 AND 5),
    comment     TEXT
);

-- Get products with their category and average rating
SELECT
    p.name AS product,
    c.name AS category,
    AVG(r.rating) AS avg_rating,
    COUNT(r.id) AS review_count
FROM products p
LEFT JOIN categories c ON p.category_id = c.id
LEFT JOIN reviews r ON p.id = r.product_id
GROUP BY p.id, p.name, c.name
ORDER BY avg_rating DESC NULLS LAST;
```

### 9.10 Visual Join Reference

```
INNER JOIN:           LEFT JOIN:            RIGHT JOIN:          FULL OUTER JOIN:
  ┌───┬───┐            ┌───┬───┐            ┌───┬───┐            ┌───┬───┐
  │   │███│            │███│███│            │   │███│            │███│███│
  │   │███│            │███│███│            │   │███│            │███│███│
  │   │███│            │███│███│            │   │███│            │███│███│
  └───┴───┘            └───┴───┘            └───┴───┘            └───┴───┘
                                             ███ = included rows
  Only matching       All left +            All right +          All rows from
  rows from both      matching right        matching left        both tables
```

---

<a id="module-10--aggregate-functions--group-by"></a>

## Module 10 — Aggregate Functions & GROUP BY

### 10.1 Aggregate Functions

These functions operate on a **set of rows** and return a single value.

```sql
-- COUNT — number of rows
SELECT COUNT(*) FROM users;                            -- count all rows
SELECT COUNT(phone) FROM users;                        -- count non-NULL phone values
SELECT COUNT(DISTINCT city) FROM users;                -- count unique cities

-- SUM — total
SELECT SUM(amount) FROM orders;
SELECT SUM(amount) AS total_revenue FROM orders WHERE order_date >= '2025-01-01';

-- AVG — average
SELECT AVG(amount) FROM orders;
SELECT ROUND(AVG(amount), 2) AS avg_order_value FROM orders;    -- round to 2 decimals

-- MIN / MAX
SELECT MIN(price), MAX(price) FROM products;
SELECT MIN(created_at) AS first_user, MAX(created_at) AS latest_user FROM users;

-- STRING_AGG — concatenate strings (like MongoDB's $push for strings)
SELECT STRING_AGG(name, ', ') FROM users WHERE role = 'admin';
-- Result: 'Alice, Bob, Charlie'

-- ARRAY_AGG — aggregate into an array
SELECT ARRAY_AGG(name) FROM users WHERE role = 'admin';
-- Result: {Alice,Bob,Charlie}
```

### 10.2 GROUP BY

Group rows that share a value, then apply aggregate functions to each group.

```sql
-- Count orders per customer
SELECT
    customer_id,
    COUNT(*) AS order_count,
    SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id;

-- With JOIN for readable results
SELECT
    c.name,
    COUNT(o.id) AS order_count,
    COALESCE(SUM(o.amount), 0) AS total_spent,
    COALESCE(ROUND(AVG(o.amount), 2), 0) AS avg_order
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.name
ORDER BY total_spent DESC;
```

> **MongoDB comparison**: `GROUP BY` is like the `$group` stage in MongoDB's aggregation pipeline.

### 10.3 HAVING (Filter Groups)

`WHERE` filters individual rows. `HAVING` filters **groups** (after GROUP BY).

```sql
-- Customers who have spent more than $500
SELECT
    c.name,
    SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.name
HAVING SUM(o.amount) > 500
ORDER BY total_spent DESC;

-- Cities with more than 5 users
SELECT
    city,
    COUNT(*) AS user_count
FROM users
GROUP BY city
HAVING COUNT(*) > 5
ORDER BY user_count DESC;
```

### 10.4 Query Execution Order

Understanding this order is crucial:

```
1. FROM       — pick the tables
2. JOIN       — combine tables
3. WHERE      — filter individual rows
4. GROUP BY   — group rows together
5. HAVING     — filter groups
6. SELECT     — pick columns and compute expressions
7. DISTINCT   — remove duplicate rows
8. ORDER BY   — sort results
9. LIMIT      — limit number of rows returned
```

This is why you can't use column aliases from SELECT in WHERE — WHERE executes before SELECT!

```sql
-- ❌ This does NOT work:
SELECT name, age * 2 AS double_age FROM users WHERE double_age > 40;

-- ✅ This works:
SELECT name, age * 2 AS double_age FROM users WHERE age * 2 > 40;

-- ✅ Or use a subquery:
SELECT * FROM (
    SELECT name, age * 2 AS double_age FROM users
) sub
WHERE double_age > 40;
```

### 10.5 Window Functions (Advanced Aggregation)

Window functions perform calculations across a set of rows **without collapsing them** into a single row (unlike GROUP BY).

```sql
-- ROW_NUMBER — assign a unique row number
SELECT
    name,
    department,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS rank
FROM employees;

-- RANK — like ROW_NUMBER but handles ties
SELECT
    name,
    department,
    salary,
    RANK() OVER (ORDER BY salary DESC) AS rank
FROM employees;
-- If two employees have the same salary, they get the same rank,
-- and the next rank is skipped (1, 2, 2, 4)

-- DENSE_RANK — no gaps in ranking
-- (1, 2, 2, 3) instead of (1, 2, 2, 4)

-- PARTITION BY — window function per group
SELECT
    name,
    department,
    salary,
    RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_rank,
    AVG(salary) OVER (PARTITION BY department) AS dept_avg_salary,
    salary - AVG(salary) OVER (PARTITION BY department) AS diff_from_avg
FROM employees;

-- Running total
SELECT
    order_date,
    amount,
    SUM(amount) OVER (ORDER BY order_date) AS running_total
FROM orders;

-- LAG / LEAD — access previous/next row
SELECT
    order_date,
    amount,
    LAG(amount) OVER (ORDER BY order_date) AS previous_amount,
    LEAD(amount) OVER (ORDER BY order_date) AS next_amount,
    amount - LAG(amount) OVER (ORDER BY order_date) AS change_from_previous
FROM orders;

-- NTILE — divide rows into N roughly equal groups
SELECT
    name,
    salary,
    NTILE(4) OVER (ORDER BY salary) AS quartile
FROM employees;
```

> **MongoDB comparison**: Window functions have **no direct equivalent** in MongoDB. This is one of SQL's biggest advantages. The closest MongoDB feature would be `$setWindowFields` (added in 5.0), but SQL window functions are far more mature and widely supported.

---

<a id="module-11--subqueries--ctes"></a>

## Module 11 — Subqueries & CTEs

### 11.1 Subqueries

A subquery is a query nested inside another query.

```sql
-- Subquery in WHERE (scalar subquery)
SELECT * FROM users
WHERE age > (SELECT AVG(age) FROM users);

-- Subquery with IN
SELECT * FROM users
WHERE id IN (
    SELECT DISTINCT user_id FROM orders WHERE amount > 100
);

-- Subquery with EXISTS (more efficient than IN for large datasets)
SELECT * FROM users u
WHERE EXISTS (
    SELECT 1 FROM orders o WHERE o.user_id = u.id AND o.amount > 100
);

-- Subquery with NOT EXISTS
SELECT * FROM users u
WHERE NOT EXISTS (
    SELECT 1 FROM orders o WHERE o.user_id = u.id
);
-- Gets users who have NEVER placed an order

-- Subquery in FROM (derived table)
SELECT department, avg_salary
FROM (
    SELECT department, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department
) dept_stats
WHERE avg_salary > 50000;

-- Subquery in SELECT (correlated subquery)
SELECT
    u.name,
    u.email,
    (SELECT COUNT(*) FROM orders o WHERE o.user_id = u.id) AS order_count,
    (SELECT COALESCE(SUM(amount), 0) FROM orders o WHERE o.user_id = u.id) AS total_spent
FROM users u;
```

### 11.2 Common Table Expressions (CTEs) — WITH Clause

CTEs make complex queries **readable and maintainable**. Think of them as temporary named result sets.

```sql
-- Basic CTE
WITH active_users AS (
    SELECT * FROM users WHERE is_active = TRUE
)
SELECT * FROM active_users WHERE age > 25;

-- Multiple CTEs
WITH
    high_spenders AS (
        SELECT
            user_id,
            SUM(amount) AS total_spent
        FROM orders
        GROUP BY user_id
        HAVING SUM(amount) > 1000
    ),
    user_details AS (
        SELECT
            u.id,
            u.name,
            u.email,
            u.city
        FROM users u
    )
SELECT
    ud.name,
    ud.email,
    ud.city,
    hs.total_spent
FROM high_spenders hs
JOIN user_details ud ON hs.user_id = ud.id
ORDER BY hs.total_spent DESC;

-- Recursive CTE (for hierarchical data like org charts, category trees)
WITH RECURSIVE org_chart AS (
    -- Base case: top-level employees (no manager)
    SELECT id, name, manager_id, 1 AS level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    -- Recursive case: employees with managers
    SELECT e.id, e.name, e.manager_id, oc.level + 1
    FROM employees e
    JOIN org_chart oc ON e.manager_id = oc.id
)
SELECT
    REPEAT('  ', level - 1) || name AS org_tree,
    level
FROM org_chart
ORDER BY level, name;
```

Result:
```
     org_tree      | level
-------------------+-------
 CEO               |     1
   VP Engineering  |     2
   VP Sales        |     2
     Senior Dev    |     3
       Junior Dev  |     4
```

---

<a id="module-12--indexes--query-performance"></a>

## Module 12 — Indexes & Query Performance

### 12.1 What Are Indexes?

An index is a data structure that speeds up data retrieval. Without an index, PostgreSQL must scan every row in a table (**sequential scan**). With an index, it can jump directly to matching rows.

> **MongoDB comparison**: Indexes work the same conceptual way! `db.collection.createIndex({ email: 1 })` is like `CREATE INDEX idx_email ON users(email)`.

### 12.2 Creating Indexes

```sql
-- Basic B-tree index (default, most common)
CREATE INDEX idx_users_email ON users(email);

-- Unique index (also enforces uniqueness)
CREATE UNIQUE INDEX idx_users_email ON users(email);

-- Composite index (multiple columns)
CREATE INDEX idx_orders_user_date ON orders(user_id, order_date DESC);

-- Partial index (index only some rows — very powerful!)
CREATE INDEX idx_active_users ON users(email) WHERE is_active = TRUE;

-- Expression index (index on a computed value)
CREATE INDEX idx_users_lower_email ON users(LOWER(email));

-- GIN index (for arrays, JSONB, full-text search)
CREATE INDEX idx_posts_tags ON posts USING GIN(tags);
CREATE INDEX idx_profiles_metadata ON profiles USING GIN(metadata);

-- GiST index (for geometric data, range types, full-text)
CREATE INDEX idx_locations ON places USING GIST(coordinates);

-- BRIN index (for naturally ordered data like timestamps)
CREATE INDEX idx_logs_created ON logs USING BRIN(created_at);

-- Concurrent index creation (doesn't lock the table — use in production!)
CREATE INDEX CONCURRENTLY idx_users_name ON users(name);
```

### 12.3 Index Types Summary

| Index Type | Best For | Example Use Case |
|---|---|---|
| **B-tree** (default) | Equality, range, sorting | `WHERE age > 25`, `ORDER BY name` |
| **Hash** | Equality only | `WHERE id = 123` (rarely better than B-tree) |
| **GIN** | Arrays, JSONB, full-text search | `WHERE tags @> ARRAY['sql']` |
| **GiST** | Geometry, ranges, nearest-neighbor | PostGIS spatial queries |
| **BRIN** | Large tables with naturally ordered data | Time-series data, log tables |

### 12.4 EXPLAIN & EXPLAIN ANALYZE

The most important tool for understanding query performance.

```sql
-- Show the query plan (without executing)
EXPLAIN SELECT * FROM users WHERE email = 'alice@example.com';

-- Show query plan AND execute (with actual timing)
EXPLAIN ANALYZE SELECT * FROM users WHERE email = 'alice@example.com';

-- More verbose output
EXPLAIN (ANALYZE, BUFFERS, FORMAT TEXT)
SELECT * FROM users WHERE email = 'alice@example.com';
```

Reading the output:
```
                                    QUERY PLAN
──────────────────────────────────────────────────────────────────────
 Seq Scan on users  (cost=0.00..1.05 rows=1 width=556)
   Filter: ((email)::text = 'alice@example.com'::text)
 Planning Time: 0.080 ms
 Execution Time: 0.040 ms
```

- **Seq Scan** = Sequential scan (bad for large tables — no index used)
- **Index Scan** = Using an index (good!)
- **cost** = Estimated cost (first number = startup cost, second = total cost)
- **rows** = Estimated number of rows
- **actual time** = Real execution time (only with ANALYZE)

After creating an index:
```sql
CREATE INDEX idx_users_email ON users(email);
EXPLAIN ANALYZE SELECT * FROM users WHERE email = 'alice@example.com';
```

```
                                    QUERY PLAN
──────────────────────────────────────────────────────────────────────
 Index Scan using idx_users_email on users  (cost=0.15..8.17 rows=1 width=556)
   Index Cond: ((email)::text = 'alice@example.com'::text)
 Planning Time: 0.100 ms
 Execution Time: 0.030 ms
```

Now it uses **Index Scan** instead of Seq Scan. 🎉

### 12.5 When to Index

**DO create indexes for:**
- Columns used in `WHERE` clauses frequently
- Columns used in `JOIN` conditions (foreign keys)
- Columns used in `ORDER BY`
- Columns used in `GROUP BY`
- Columns with `UNIQUE` constraints (auto-created)
- Primary keys (auto-created)

**DO NOT over-index because:**
- Each index slows down `INSERT`, `UPDATE`, `DELETE` operations
- Indexes consume disk space
- Too many indexes can confuse the query planner

### 12.6 Managing Indexes

```sql
-- List all indexes on a table
\di users

-- Or query the system catalog
SELECT indexname, indexdef FROM pg_indexes WHERE tablename = 'users';

-- Drop an index
DROP INDEX idx_users_email;

-- Drop concurrently (in production)
DROP INDEX CONCURRENTLY idx_users_email;

-- Rebuild an index
REINDEX INDEX idx_users_email;

-- Check index size
SELECT pg_size_pretty(pg_relation_size('idx_users_email'));

-- Check if index is being used
SELECT
    schemaname,
    relname AS table,
    indexrelname AS index,
    idx_scan AS times_used,
    pg_size_pretty(pg_relation_size(indexrelid)) AS index_size
FROM pg_stat_user_indexes
ORDER BY idx_scan ASC;
-- Indexes with idx_scan = 0 might be candidates for removal
```

---

<a id="module-13--views--materialized-views"></a>

## Module 13 — Views & Materialized Views

### 13.1 Views (Virtual Tables)

A view is a **saved query** that acts like a virtual table. It doesn't store data — it runs the query each time you access it.

```sql
-- Create a view
CREATE VIEW active_users_with_orders AS
SELECT
    u.id,
    u.name,
    u.email,
    COUNT(o.id) AS order_count,
    COALESCE(SUM(o.amount), 0) AS total_spent
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
WHERE u.is_active = TRUE
GROUP BY u.id, u.name, u.email;

-- Use it like a regular table
SELECT * FROM active_users_with_orders;
SELECT * FROM active_users_with_orders WHERE total_spent > 100;

-- Drop a view
DROP VIEW active_users_with_orders;

-- Create or replace (update definition)
CREATE OR REPLACE VIEW active_users_with_orders AS
SELECT ... ;   -- new query
```

**Use cases for views:**
- Simplify complex queries that are used frequently
- Provide a security layer (expose limited data to certain users)
- Create backward-compatible interfaces when table structures change

### 13.2 Materialized Views (Cached Query Results)

A materialized view **stores the query result** on disk. Faster to read, but the data can become stale.

```sql
-- Create a materialized view
CREATE MATERIALIZED VIEW monthly_sales AS
SELECT
    DATE_TRUNC('month', order_date) AS month,
    COUNT(*) AS order_count,
    SUM(amount) AS total_revenue,
    AVG(amount) AS avg_order_value
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

-- Query it (fast — reads from stored data)
SELECT * FROM monthly_sales;

-- Refresh the data (must do this manually or via a cron job)
REFRESH MATERIALIZED VIEW monthly_sales;

-- Refresh concurrently (requires a UNIQUE INDEX, doesn't lock reads)
CREATE UNIQUE INDEX idx_monthly_sales_month ON monthly_sales(month);
REFRESH MATERIALIZED VIEW CONCURRENTLY monthly_sales;

-- Drop
DROP MATERIALIZED VIEW monthly_sales;
```

**Use materialized views for:**
- Dashboard/analytics queries that are expensive but don't need real-time data
- Reports that can be refreshed periodically (hourly, daily)
- Precomputed aggregations

---

<a id="module-14--transactions--acid"></a>

## Module 14 — Transactions & ACID

### 14.1 What is ACID?

| Property | Meaning | Example |
|---|---|---|
| **A**tomicity | All or nothing — either all operations succeed, or none do | Transferring money: debit AND credit must both happen |
| **C**onsistency | Database moves from one valid state to another | Constraints are always satisfied |
| **I**solation | Concurrent transactions don't interfere with each other | Two users buying the last item won't both succeed |
| **D**urability | Once committed, data survives crashes | Power outage after commit = data is safe |

> **MongoDB comparison**: MongoDB supports multi-document transactions since version 4.0, but PostgreSQL has had rock-solid ACID compliance since its inception. PostgreSQL transactions are simpler and more mature.

### 14.2 Transaction Basics

```sql
-- Start a transaction
BEGIN;
-- (or: START TRANSACTION;)

-- Perform operations
UPDATE accounts SET balance = balance - 500 WHERE id = 1;  -- debit
UPDATE accounts SET balance = balance + 500 WHERE id = 2;  -- credit

-- If everything is good, commit
COMMIT;

-- If something went wrong, rollback
ROLLBACK;
```

### 14.3 Practical Example: Money Transfer

```sql
BEGIN;

-- Check if sender has enough balance
DO $$
DECLARE
    sender_balance DECIMAL(10,2);
BEGIN
    SELECT balance INTO sender_balance FROM accounts WHERE id = 1 FOR UPDATE;

    IF sender_balance < 500 THEN
        RAISE EXCEPTION 'Insufficient funds';
    END IF;

    UPDATE accounts SET balance = balance - 500 WHERE id = 1;
    UPDATE accounts SET balance = balance + 500 WHERE id = 2;
END $$;

COMMIT;
```

### 14.4 Savepoints

```sql
BEGIN;

INSERT INTO orders (user_id, product, amount) VALUES (1, 'Laptop', 999);
SAVEPOINT before_details;

INSERT INTO order_details (order_id, color, size) VALUES (1, 'Silver', 'Large');
-- Oops, wrong data! Roll back to savepoint
ROLLBACK TO SAVEPOINT before_details;

-- Fix and retry
INSERT INTO order_details (order_id, color, size) VALUES (1, 'Space Gray', 'Medium');

COMMIT;
-- The order is committed, and the correct details are saved
```

### 14.5 Isolation Levels

```sql
-- Set transaction isolation level
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;     -- default
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;       -- strictest

-- Check current isolation level
SHOW transaction_isolation;
```

| Level | Dirty Read | Non-repeatable Read | Phantom Read |
|---|---|---|---|
| `READ COMMITTED` (default) | ❌ Prevented | ⚠️ Possible | ⚠️ Possible |
| `REPEATABLE READ` | ❌ Prevented | ❌ Prevented | ⚠️ Possible |
| `SERIALIZABLE` | ❌ Prevented | ❌ Prevented | ❌ Prevented |

- **READ COMMITTED**: Each query sees only data committed before it started. Good for most use cases.
- **REPEATABLE READ**: Sees a snapshot from the start of the transaction. Good for reports.
- **SERIALIZABLE**: Fully isolated. Transactions behave as if they ran one at a time. Use for critical financial operations.

---

<a id="module-15--functions--stored-procedures"></a>

## Module 15 — Functions & Stored Procedures

### 15.1 Built-in Functions

#### String Functions
```sql
SELECT LENGTH('Hello World');                  -- 11
SELECT UPPER('hello');                         -- 'HELLO'
SELECT LOWER('HELLO');                         -- 'hello'
SELECT TRIM('  hello  ');                      -- 'hello'
SELECT LTRIM('  hello');                       -- 'hello'
SELECT RTRIM('hello  ');                       -- 'hello'
SELECT SUBSTRING('Hello World' FROM 1 FOR 5); -- 'Hello'
SELECT LEFT('Hello', 3);                       -- 'Hel'
SELECT RIGHT('Hello', 3);                      -- 'llo'
SELECT REPLACE('Hello World', 'World', 'PG');  -- 'Hello PG'
SELECT CONCAT('Hello', ' ', 'World');          -- 'Hello World'
SELECT 'Hello' || ' ' || 'World';             -- 'Hello World' (concatenation)
SELECT REVERSE('Hello');                       -- 'olleH'
SELECT REPEAT('ab', 3);                        -- 'ababab'
SELECT POSITION('World' IN 'Hello World');     -- 7
SELECT SPLIT_PART('a.b.c.d', '.', 2);        -- 'b'
SELECT INITCAP('hello world');                 -- 'Hello World'
SELECT LPAD('42', 5, '0');                     -- '00042'
SELECT RPAD('hello', 10, '.');                 -- 'hello.....'
SELECT MD5('password');                        -- hash
SELECT ENCODE(SHA256('password'::BYTEA), 'hex'); -- SHA256 hash
```

#### Math Functions
```sql
SELECT ABS(-42);                -- 42
SELECT CEIL(4.1);               -- 5
SELECT FLOOR(4.9);              -- 4
SELECT ROUND(4.567, 2);         -- 4.57
SELECT TRUNC(4.567, 2);         -- 4.56  (truncate, not round)
SELECT MOD(10, 3);              -- 1
SELECT POWER(2, 10);            -- 1024
SELECT SQRT(144);               -- 12
SELECT RANDOM();                -- 0.0 to 1.0
SELECT FLOOR(RANDOM() * 100);   -- random int 0-99
SELECT GREATEST(10, 20, 30);    -- 30
SELECT LEAST(10, 20, 30);       -- 10
```

#### Conditional Functions
```sql
-- CASE expression (like if/else or switch)
SELECT
    name,
    salary,
    CASE
        WHEN salary >= 100000 THEN 'Senior'
        WHEN salary >= 60000  THEN 'Mid'
        WHEN salary >= 30000  THEN 'Junior'
        ELSE 'Intern'
    END AS level
FROM employees;

-- COALESCE — return first non-NULL value (like MongoDB's $ifNull)
SELECT COALESCE(phone, email, 'No Contact') AS contact FROM users;

-- NULLIF — return NULL if two values are equal
SELECT NULLIF(discount, 0) FROM products;  -- returns NULL instead of 0

-- CAST — type conversion
SELECT CAST('42' AS INTEGER);
SELECT '42'::INTEGER;                      -- PostgreSQL shorthand
SELECT CAST(NOW() AS DATE);
SELECT NOW()::DATE;
```

### 15.2 Creating Custom Functions

```sql
-- Simple function
CREATE OR REPLACE FUNCTION calculate_tax(price DECIMAL, tax_rate DECIMAL DEFAULT 0.08)
RETURNS DECIMAL AS $$
BEGIN
    RETURN ROUND(price * tax_rate, 2);
END;
$$ LANGUAGE plpgsql;

-- Use it
SELECT calculate_tax(100);         -- 8.00
SELECT calculate_tax(100, 0.10);   -- 10.00

-- Function that returns a table
CREATE OR REPLACE FUNCTION get_top_customers(min_spent DECIMAL DEFAULT 1000)
RETURNS TABLE (
    customer_name VARCHAR,
    total_spent DECIMAL
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        c.name,
        SUM(o.amount)
    FROM customers c
    JOIN orders o ON c.id = o.customer_id
    GROUP BY c.name
    HAVING SUM(o.amount) >= min_spent
    ORDER BY SUM(o.amount) DESC;
END;
$$ LANGUAGE plpgsql;

-- Use it
SELECT * FROM get_top_customers(500);

-- SQL function (simpler syntax for simple functions)
CREATE OR REPLACE FUNCTION full_name(first_name TEXT, last_name TEXT)
RETURNS TEXT AS $$
    SELECT first_name || ' ' || last_name;
$$ LANGUAGE sql;
```

### 15.3 Stored Procedures (PostgreSQL 11+)

Procedures differ from functions: they can manage transactions and don't return values.

```sql
-- Create a procedure
CREATE OR REPLACE PROCEDURE transfer_money(
    sender_id INTEGER,
    receiver_id INTEGER,
    amount DECIMAL
)
LANGUAGE plpgsql
AS $$
DECLARE
    sender_balance DECIMAL;
BEGIN
    -- Check sender balance
    SELECT balance INTO sender_balance FROM accounts WHERE id = sender_id FOR UPDATE;

    IF sender_balance < amount THEN
        RAISE EXCEPTION 'Insufficient funds. Balance: %, Requested: %', sender_balance, amount;
    END IF;

    -- Perform transfer
    UPDATE accounts SET balance = balance - amount WHERE id = sender_id;
    UPDATE accounts SET balance = balance + amount WHERE id = receiver_id;

    -- Log the transaction
    INSERT INTO transaction_log (from_id, to_id, amount, created_at)
    VALUES (sender_id, receiver_id, amount, NOW());

    COMMIT;
END;
$$;

-- Call a procedure
CALL transfer_money(1, 2, 500.00);
```

### 15.4 Managing Functions

```sql
-- List all custom functions
\df

-- Get function definition
\df+ function_name

-- Drop a function
DROP FUNCTION IF EXISTS calculate_tax(DECIMAL, DECIMAL);

-- Drop a procedure
DROP PROCEDURE IF EXISTS transfer_money(INTEGER, INTEGER, DECIMAL);
```

---

<a id="module-16--triggers--event-driven-logic"></a>

## Module 16 — Triggers & Event-Driven Logic

### 16.1 What Are Triggers?

Triggers automatically execute a function when a specific event (INSERT, UPDATE, DELETE) occurs on a table.

> **MongoDB comparison**: Similar to MongoDB Change Streams, but triggers run inside the database itself (not in your application code).

### 16.2 Creating Triggers

```sql
-- Step 1: Create a trigger function (must return TRIGGER type)
CREATE OR REPLACE FUNCTION update_modified_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Step 2: Attach the trigger to a table
CREATE TRIGGER trg_users_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW
    EXECUTE FUNCTION update_modified_at();

-- Now, every time you UPDATE a user, updated_at is automatically set to NOW()
UPDATE users SET name = 'Alice Updated' WHERE id = 1;
-- updated_at is automatically set! No need to do it in your app code.
```

### 16.3 Trigger Types

| Type | When It Fires | Use Case |
|---|---|---|
| `BEFORE INSERT` | Before a new row is inserted | Validate/modify data before insert |
| `AFTER INSERT` | After a new row is inserted | Log the insertion, send notification |
| `BEFORE UPDATE` | Before a row is updated | Set `updated_at`, validate changes |
| `AFTER UPDATE` | After a row is updated | Audit trail, sync to another table |
| `BEFORE DELETE` | Before a row is deleted | Prevent deletion, soft delete |
| `AFTER DELETE` | After a row is deleted | Clean up related data, log deletion |
| `INSTEAD OF` | Used on views only | Make views updatable |

### 16.4 Audit Trail Example

```sql
-- Audit log table
CREATE TABLE audit_log (
    id          SERIAL PRIMARY KEY,
    table_name  VARCHAR(100) NOT NULL,
    action      VARCHAR(10) NOT NULL,
    row_id      INTEGER NOT NULL,
    old_data    JSONB,
    new_data    JSONB,
    changed_by  VARCHAR(100) DEFAULT current_user,
    changed_at  TIMESTAMPTZ DEFAULT NOW()
);

-- Trigger function
CREATE OR REPLACE FUNCTION audit_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO audit_log (table_name, action, row_id, new_data)
        VALUES (TG_TABLE_NAME, 'INSERT', NEW.id, to_jsonb(NEW));
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit_log (table_name, action, row_id, old_data, new_data)
        VALUES (TG_TABLE_NAME, 'UPDATE', NEW.id, to_jsonb(OLD), to_jsonb(NEW));
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO audit_log (table_name, action, row_id, old_data)
        VALUES (TG_TABLE_NAME, 'DELETE', OLD.id, to_jsonb(OLD));
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Attach to a table
CREATE TRIGGER trg_users_audit
    AFTER INSERT OR UPDATE OR DELETE ON users
    FOR EACH ROW EXECUTE FUNCTION audit_trigger();
```

### 16.5 Managing Triggers

```sql
-- List triggers on a table
SELECT * FROM information_schema.triggers WHERE event_object_table = 'users';

-- Disable a trigger temporarily
ALTER TABLE users DISABLE TRIGGER trg_users_audit;

-- Enable it back
ALTER TABLE users ENABLE TRIGGER trg_users_audit;

-- Drop a trigger
DROP TRIGGER trg_users_audit ON users;
```

---

<a id="module-17--jsonjsonb"></a>

## Module 17 — JSON/JSONB

This module is especially important for you as a MongoDB user! PostgreSQL's JSONB gives you document-like flexibility within a relational database.

### 17.1 JSON vs JSONB

| Feature | JSON | JSONB |
|---|---|---|
| Storage | Plain text | Binary (parsed & optimized) |
| Speed (read) | Slower (must parse each time) | Faster |
| Speed (write) | Slightly faster | Slightly slower (must parse) |
| Indexing | ❌ Not supported | ✅ GIN, GiST indexes |
| Duplicate keys | ✅ Preserved | ❌ Last value wins |
| Key ordering | ✅ Preserved | ❌ Not guaranteed |
| **Recommendation** | Rarely use | **Always use JSONB** |

### 17.2 JSONB Operators

```sql
CREATE TABLE products (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(200) NOT NULL,
    details     JSONB NOT NULL DEFAULT '{}'
);

INSERT INTO products (name, details) VALUES
('Laptop', '{
    "brand": "TechCo",
    "specs": {
        "cpu": "i7-12700H",
        "ram": 16,
        "storage": "512GB SSD"
    },
    "colors": ["silver", "black", "white"],
    "price": 999.99,
    "in_stock": true
}');
```

#### Accessing JSON Values

```sql
-- -> returns JSON object/array (keeps JSON type)
SELECT details->'specs' FROM products;
-- {"cpu": "i7-12700H", "ram": 16, "storage": "512GB SSD"}

-- ->> returns text (extracts as string)
SELECT details->>'brand' FROM products;
-- TechCo

-- Nested access
SELECT details->'specs'->>'cpu' FROM products;
-- i7-12700H

-- #> path access (returns JSON)
SELECT details #> '{specs,cpu}' FROM products;
-- "i7-12700H"

-- #>> path access (returns text)
SELECT details #>> '{specs,cpu}' FROM products;
-- i7-12700H

-- Array access (0-indexed)
SELECT details->'colors'->0 FROM products;       -- "silver"
SELECT details->'colors'->>1 FROM products;      -- black
```

#### Querying JSONB

```sql
-- Check if a key exists
SELECT * FROM products WHERE details ? 'brand';

-- Check if ANY of the keys exist
SELECT * FROM products WHERE details ?| ARRAY['brand', 'model'];

-- Check if ALL keys exist
SELECT * FROM products WHERE details ?& ARRAY['brand', 'price'];

-- Contains (like MongoDB's $elemMatch for objects)
SELECT * FROM products WHERE details @> '{"brand": "TechCo"}';

-- Contained by
SELECT * FROM products WHERE '{"brand": "TechCo", "price": 999.99}' @> details;

-- Compare extracted values
SELECT * FROM products WHERE (details->>'price')::DECIMAL > 500;
SELECT * FROM products WHERE details->'specs'->>'ram' = '16';

-- Array contains element
SELECT * FROM products WHERE details->'colors' ? 'silver';

-- Full-path query
SELECT * FROM products WHERE details #>> '{specs,cpu}' LIKE '%i7%';
```

### 17.3 Modifying JSONB

```sql
-- Set/update a top-level key
UPDATE products
SET details = jsonb_set(details, '{brand}', '"NewBrand"')
WHERE id = 1;

-- Set a nested key
UPDATE products
SET details = jsonb_set(details, '{specs,ram}', '32')
WHERE id = 1;

-- Add a new key
UPDATE products
SET details = details || '{"warranty": "2 years"}'::jsonb
WHERE id = 1;

-- Remove a key
UPDATE products
SET details = details - 'warranty'
WHERE id = 1;

-- Remove a nested key
UPDATE products
SET details = details #- '{specs,storage}'
WHERE id = 1;

-- Append to a JSON array
UPDATE products
SET details = jsonb_set(
    details,
    '{colors}',
    (details->'colors') || '"gold"'::jsonb
)
WHERE id = 1;
```

### 17.4 JSONB Functions

```sql
-- Pretty print JSON
SELECT jsonb_pretty(details) FROM products;

-- Get all keys
SELECT jsonb_object_keys(details) FROM products;

-- Convert JSON to rows (like MongoDB's $unwind)
SELECT jsonb_array_elements_text(details->'colors') AS color
FROM products;

-- Build JSON from rows
SELECT jsonb_build_object(
    'name', name,
    'email', email,
    'age', age
) FROM users;

-- Aggregate rows into a JSON array
SELECT jsonb_agg(jsonb_build_object('id', id, 'name', name))
FROM users;

-- Get key-value pairs
SELECT key, value
FROM products, jsonb_each(details)
WHERE id = 1;

-- Check JSON type
SELECT jsonb_typeof(details->'price') FROM products;  -- 'number'
SELECT jsonb_typeof(details->'colors') FROM products;  -- 'array'
SELECT jsonb_typeof(details->'brand') FROM products;   -- 'string'
```

### 17.5 Indexing JSONB

```sql
-- GIN index on entire JSONB column (supports @>, ?, ?|, ?&)
CREATE INDEX idx_products_details ON products USING GIN(details);

-- GIN index with jsonb_path_ops (smaller, faster, only supports @>)
CREATE INDEX idx_products_details_path ON products USING GIN(details jsonb_path_ops);

-- B-tree index on a specific extracted value
CREATE INDEX idx_products_brand ON products ((details->>'brand'));

-- Expression index for numeric values
CREATE INDEX idx_products_price ON products (((details->>'price')::DECIMAL));
```

> **Key takeaway**: PostgreSQL JSONB gives you the flexibility of MongoDB while keeping all the relational database advantages (transactions, joins, constraints). You can mix structured columns with JSONB columns in the same table!

---

<a id="module-18--user-management-roles--permissions"></a>

## Module 18 — User Management, Roles & Permissions

### 18.1 Roles & Users

In PostgreSQL, there's no distinction between "users" and "groups" — they're all **roles**. A role can have login permission (user) or not (group).

```sql
-- Create a role that can log in (i.e., a user)
CREATE ROLE app_user WITH LOGIN PASSWORD 'securepassword123';

-- Create a role without login (i.e., a group)
CREATE ROLE readonly;

-- Create with multiple options
CREATE ROLE admin_user WITH
    LOGIN
    PASSWORD 'adminpass'
    SUPERUSER
    CREATEDB
    CREATEROLE
    VALID UNTIL '2026-01-01';

-- Alter a role
ALTER ROLE app_user WITH PASSWORD 'newpassword';
ALTER ROLE app_user VALID UNTIL 'infinity';

-- List roles
\du

-- Drop a role
DROP ROLE app_user;
```

### 18.2 Granting Privileges

```sql
-- Grant permissions on a database
GRANT CONNECT ON DATABASE myapp TO app_user;

-- Grant permissions on schema
GRANT USAGE ON SCHEMA public TO app_user;

-- Grant permissions on tables
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON users TO app_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO admin_user;

-- Grant permissions on sequences (needed for SERIAL columns)
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO app_user;

-- Grant a role to another role (role inheritance)
GRANT readonly TO app_user;    -- app_user inherits readonly's permissions

-- Set default privileges for future tables
ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT ON TABLES TO readonly;
```

### 18.3 Revoking Privileges

```sql
-- Revoke specific privileges
REVOKE INSERT, UPDATE ON users FROM app_user;

-- Revoke all privileges
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM app_user;

-- Revoke role membership
REVOKE readonly FROM app_user;
```

### 18.4 Row-Level Security (RLS)

RLS lets you control which rows a user can see or modify — powerful for multi-tenant apps!

```sql
-- Enable RLS on a table
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;

-- Create a policy: users can only see their own posts
CREATE POLICY user_posts_policy ON posts
    FOR ALL
    USING (user_id = current_setting('app.current_user_id')::INTEGER);

-- Create a policy: admins can see everything
CREATE POLICY admin_all_access ON posts
    FOR ALL
    TO admin_role
    USING (TRUE);

-- Set the current user ID (do this from your application)
SET app.current_user_id = '42';

-- Now: SELECT * FROM posts;  -- only returns posts where user_id = 42
```

---

<a id="module-19--backup-restore--maintenance"></a>

## Module 19 — Backup, Restore & Maintenance

### 19.1 Backup Methods

#### pg_dump (Logical Backup)

```bash
# Backup a single database to a SQL file
pg_dump -U postgres -d myapp > backup.sql

# Backup with compression
pg_dump -U postgres -d myapp -Fc -f backup.dump       # Custom format (recommended)
pg_dump -U postgres -d myapp -Ft -f backup.tar         # Tar format

# Backup specific tables
pg_dump -U postgres -d myapp -t users -t orders > tables_backup.sql

# Backup schema only (no data)
pg_dump -U postgres -d myapp --schema-only > schema.sql

# Backup data only (no schema)
pg_dump -U postgres -d myapp --data-only > data.sql
```

#### pg_dumpall (All Databases)

```bash
# Backup ALL databases and global objects (roles, tablespaces)
pg_dumpall -U postgres > full_backup.sql

# Backup only global objects
pg_dumpall -U postgres --globals-only > globals.sql
```

### 19.2 Restore

```bash
# Restore from SQL file
psql -U postgres -d myapp < backup.sql

# Restore from custom format (.dump)
pg_restore -U postgres -d myapp backup.dump

# Restore with options
pg_restore -U postgres -d myapp --clean --if-exists backup.dump
# --clean: drop existing objects before restore
# --if-exists: don't error if objects don't exist
```

### 19.3 Maintenance Tasks

```sql
-- VACUUM — reclaim storage from dead rows (PostgreSQL's garbage collection)
VACUUM users;                   -- basic vacuum
VACUUM FULL users;              -- aggressive, rewrites the entire table (locks it!)
VACUUM ANALYZE users;           -- vacuum + update query planner statistics

-- ANALYZE — update statistics for the query planner
ANALYZE;                        -- all tables
ANALYZE users;                  -- specific table

-- REINDEX — rebuild indexes
REINDEX TABLE users;
REINDEX DATABASE myapp;

-- Check table size
SELECT pg_size_pretty(pg_total_relation_size('users'));    -- includes indexes
SELECT pg_size_pretty(pg_table_size('users'));             -- table only
SELECT pg_size_pretty(pg_indexes_size('users'));           -- indexes only

-- Check database size
SELECT pg_size_pretty(pg_database_size('myapp'));

-- Check for dead rows (need for VACUUM)
SELECT
    relname AS table,
    n_live_tup AS live_rows,
    n_dead_tup AS dead_rows,
    ROUND(n_dead_tup * 100.0 / NULLIF(n_live_tup + n_dead_tup, 0), 2) AS dead_pct
FROM pg_stat_user_tables
ORDER BY dead_pct DESC;
```

### 19.4 Autovacuum

PostgreSQL has an **autovacuum** daemon that automatically runs VACUUM and ANALYZE in the background. It's enabled by default — **don't disable it!**

```sql
-- Check autovacuum settings
SHOW autovacuum;
SHOW autovacuum_naptime;

-- Check when tables were last vacuumed/analyzed
SELECT
    relname,
    last_vacuum,
    last_autovacuum,
    last_analyze,
    last_autoanalyze
FROM pg_stat_user_tables;
```

---

<a id="module-20--advanced-topics"></a>

## Module 20 — Advanced Topics

### 20.1 Full-Text Search

PostgreSQL has built-in full-text search — no need for Elasticsearch for many use cases!

```sql
-- Basic full-text search
SELECT * FROM articles
WHERE to_tsvector('english', title || ' ' || content) @@ to_tsquery('english', 'postgresql & tutorial');

-- Create a tsvector column and index for performance
ALTER TABLE articles ADD COLUMN search_vector TSVECTOR;

UPDATE articles SET search_vector =
    to_tsvector('english', COALESCE(title, '') || ' ' || COALESCE(content, ''));

CREATE INDEX idx_articles_search ON articles USING GIN(search_vector);

-- Search using the pre-computed vector
SELECT title, ts_rank(search_vector, query) AS rank
FROM articles, to_tsquery('english', 'postgresql | database') query
WHERE search_vector @@ query
ORDER BY rank DESC;

-- Auto-update search vector with a trigger
CREATE TRIGGER trg_articles_search_vector
    BEFORE INSERT OR UPDATE ON articles
    FOR EACH ROW EXECUTE FUNCTION
    tsvector_update_trigger(search_vector, 'pg_catalog.english', title, content);
```

### 20.2 Partitioning (For Very Large Tables)

```sql
-- Range partitioning (e.g., by date)
CREATE TABLE logs (
    id          BIGSERIAL,
    message     TEXT NOT NULL,
    level       VARCHAR(20),
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
) PARTITION BY RANGE (created_at);

-- Create partitions
CREATE TABLE logs_2025_q1 PARTITION OF logs
    FOR VALUES FROM ('2025-01-01') TO ('2025-04-01');

CREATE TABLE logs_2025_q2 PARTITION OF logs
    FOR VALUES FROM ('2025-04-01') TO ('2025-07-01');

CREATE TABLE logs_2025_q3 PARTITION OF logs
    FOR VALUES FROM ('2025-07-01') TO ('2025-10-01');

-- Queries automatically route to the correct partition
SELECT * FROM logs WHERE created_at BETWEEN '2025-04-01' AND '2025-06-30';
-- Only scans logs_2025_q2, not the entire table!
```

### 20.3 LISTEN / NOTIFY (Real-time Events)

PostgreSQL has a built-in pub/sub system!

```sql
-- In Terminal 1: Listen for events
LISTEN new_order;

-- In Terminal 2: Send a notification
NOTIFY new_order, '{"order_id": 42, "user": "Alice", "amount": 99.99}';

-- Terminal 1 receives:
-- Asynchronous notification "new_order" with payload "{"order_id": 42, ...}" received

-- Use in triggers for real-time notifications
CREATE OR REPLACE FUNCTION notify_new_order()
RETURNS TRIGGER AS $$
BEGIN
    PERFORM pg_notify('new_order', row_to_json(NEW)::TEXT);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_notify_order
    AFTER INSERT ON orders
    FOR EACH ROW EXECUTE FUNCTION notify_new_order();
```

### 20.4 Extensions

PostgreSQL's superpower — extend the database with plugins.

```sql
-- List available extensions
SELECT * FROM pg_available_extensions ORDER BY name;

-- Install an extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";      -- UUID functions
CREATE EXTENSION IF NOT EXISTS "pgcrypto";        -- Cryptographic functions
CREATE EXTENSION IF NOT EXISTS "pg_trgm";         -- Trigram matching (fuzzy search)
CREATE EXTENSION IF NOT EXISTS "hstore";          -- Key-value pairs

-- Popular extensions:
-- PostGIS         — geospatial data (like MongoDB's GeoJSON but much more powerful)
-- pg_trgm         — similarity search, fuzzy matching
-- pgcrypto        — encryption and hashing
-- uuid-ossp       — UUID generation
-- pg_stat_statements — query performance tracking
-- timescaledb     — time-series data
-- Citus           — horizontal scaling / sharding
```

### 20.5 pg_stat_statements (Query Performance Monitoring)

```sql
-- Enable the extension
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

-- View slowest queries
SELECT
    query,
    calls,
    ROUND(total_exec_time::NUMERIC, 2) AS total_time_ms,
    ROUND(mean_exec_time::NUMERIC, 2) AS avg_time_ms,
    rows
FROM pg_stat_statements
ORDER BY total_exec_time DESC
LIMIT 20;
```

---

<a id="module-21--postgresql-with-nodejs"></a>

## Module 21 — PostgreSQL with Node.js

### 21.1 Using `pg` (node-postgres) — The Standard Driver

```bash
npm install pg
```

```javascript
// db.js — Connection setup
const { Pool } = require('pg');

const pool = new Pool({
  host: 'localhost',
  port: 5432,
  database: 'myapp',
  user: 'postgres',
  password: 'yourpassword',
  max: 20,                      // max connections in pool
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
});

module.exports = pool;
```

```javascript
// Basic CRUD Operations
const pool = require('./db');

// CREATE
async function createUser(name, email, age) {
  const result = await pool.query(
    'INSERT INTO users (name, email, age) VALUES ($1, $2, $3) RETURNING *',
    [name, email, age]
  );
  return result.rows[0];
}

// READ
async function getUserById(id) {
  const result = await pool.query(
    'SELECT * FROM users WHERE id = $1',
    [id]
  );
  return result.rows[0]; // undefined if not found
}

// READ ALL with pagination
async function getUsers(page = 1, limit = 10) {
  const offset = (page - 1) * limit;
  const result = await pool.query(
    'SELECT * FROM users ORDER BY id LIMIT $1 OFFSET $2',
    [limit, offset]
  );
  
  const countResult = await pool.query('SELECT COUNT(*) FROM users');
  
  return {
    users: result.rows,
    total: parseInt(countResult.rows[0].count),
    page,
    totalPages: Math.ceil(parseInt(countResult.rows[0].count) / limit)
  };
}

// UPDATE
async function updateUser(id, name, email) {
  const result = await pool.query(
    'UPDATE users SET name = $1, email = $2 WHERE id = $3 RETURNING *',
    [name, email, id]
  );
  return result.rows[0];
}

// DELETE
async function deleteUser(id) {
  const result = await pool.query(
    'DELETE FROM users WHERE id = $1 RETURNING *',
    [id]
  );
  return result.rows[0];
}

// TRANSACTION
async function transferMoney(fromId, toId, amount) {
  const client = await pool.connect();
  try {
    await client.query('BEGIN');
    
    await client.query(
      'UPDATE accounts SET balance = balance - $1 WHERE id = $2',
      [amount, fromId]
    );
    
    await client.query(
      'UPDATE accounts SET balance = balance + $1 WHERE id = $2',
      [amount, toId]
    );
    
    await client.query('COMMIT');
  } catch (error) {
    await client.query('ROLLBACK');
    throw error;
  } finally {
    client.release();
  }
}
```

> **MongoDB comparison**:
> - `MongoClient` → `Pool` (connection pooling)
> - `db.collection('users').findOne({ _id })` → `pool.query('SELECT * FROM users WHERE id = $1', [id])`
> - `$1, $2, $3` are **parameterized queries** — they prevent SQL injection (like MongoDB's query objects prevent NoSQL injection)

### 21.2 Express.js + PostgreSQL Example

```javascript
const express = require('express');
const pool = require('./db');
const app = express();

app.use(express.json());

// GET all users
app.get('/api/users', async (req, res) => {
  try {
    const { page = 1, limit = 10 } = req.query;
    const offset = (page - 1) * limit;
    
    const result = await pool.query(
      'SELECT id, name, email, created_at FROM users ORDER BY id LIMIT $1 OFFSET $2',
      [limit, offset]
    );
    
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET user by ID
app.get('/api/users/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const result = await pool.query('SELECT * FROM users WHERE id = $1', [id]);
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }
    
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// POST create user
app.post('/api/users', async (req, res) => {
  try {
    const { name, email, age } = req.body;
    const result = await pool.query(
      'INSERT INTO users (name, email, age) VALUES ($1, $2, $3) RETURNING *',
      [name, email, age]
    );
    res.status(201).json(result.rows[0]);
  } catch (err) {
    if (err.code === '23505') { // unique violation
      return res.status(409).json({ error: 'Email already exists' });
    }
    res.status(500).json({ error: err.message });
  }
});

// PUT update user
app.put('/api/users/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const { name, email, age } = req.body;
    const result = await pool.query(
      'UPDATE users SET name = $1, email = $2, age = $3 WHERE id = $4 RETURNING *',
      [name, email, age, id]
    );
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }
    
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// DELETE user
app.delete('/api/users/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const result = await pool.query(
      'DELETE FROM users WHERE id = $1 RETURNING *',
      [id]
    );
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }
    
    res.json({ message: 'User deleted', user: result.rows[0] });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.listen(3000, () => console.log('Server on port 3000'));
```

---

<a id="module-22--orms"></a>

## Module 22 — ORMs

### 22.1 Prisma (Most Popular Modern ORM)

Prisma is like **Mongoose for PostgreSQL** — it provides a schema, type safety, and an intuitive API.

```bash
npm install prisma @prisma/client
npx prisma init
```

```prisma
// prisma/schema.prisma
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

generator client {
  provider = "prisma-client-js"
}

model User {
  id        Int      @id @default(autoincrement())
  name      String
  email     String   @unique
  age       Int?
  isActive  Boolean  @default(true)
  createdAt DateTime @default(now())
  posts     Post[]   // one-to-many relationship

  @@map("users")     // maps to "users" table
}

model Post {
  id        Int      @id @default(autoincrement())
  title     String
  content   String?
  published Boolean  @default(false)
  authorId  Int
  author    User     @relation(fields: [authorId], references: [id], onDelete: Cascade)
  tags      Tag[]    // many-to-many

  @@map("posts")
}

model Tag {
  id    Int    @id @default(autoincrement())
  name  String @unique
  posts Post[]

  @@map("tags")
}
```

```bash
# Generate/update database from schema
npx prisma migrate dev --name init

# Generate Prisma client
npx prisma generate

# Open Prisma Studio (GUI like MongoDB Compass)
npx prisma studio
```

```javascript
// Using Prisma Client
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

// CREATE
const user = await prisma.user.create({
  data: { name: 'Alice', email: 'alice@mail.com', age: 28 }
});

// READ
const user = await prisma.user.findUnique({ where: { id: 1 } });
const user = await prisma.user.findUnique({ where: { email: 'alice@mail.com' } });

// READ with relations (like MongoDB's populate / $lookup)
const userWithPosts = await prisma.user.findUnique({
  where: { id: 1 },
  include: { posts: true }
});

// READ ALL with filtering, sorting, pagination
const users = await prisma.user.findMany({
  where: { age: { gte: 18 }, isActive: true },
  orderBy: { createdAt: 'desc' },
  skip: 0,
  take: 10,
  select: { id: true, name: true, email: true }
});

// UPDATE
const updated = await prisma.user.update({
  where: { id: 1 },
  data: { name: 'Alice Updated' }
});

// DELETE
const deleted = await prisma.user.delete({ where: { id: 1 } });

// TRANSACTION
const result = await prisma.$transaction([
  prisma.account.update({ where: { id: 1 }, data: { balance: { decrement: 500 } } }),
  prisma.account.update({ where: { id: 2 }, data: { balance: { increment: 500 } } }),
]);
```

> **If you know Mongoose, Prisma will feel very familiar!**

### 22.2 Drizzle ORM (Lightweight, SQL-like)

```bash
npm install drizzle-orm pg
npm install -D drizzle-kit
```

```javascript
// schema.js
const { pgTable, serial, varchar, integer, boolean, timestamp } = require('drizzle-orm/pg-core');

const users = pgTable('users', {
  id: serial('id').primaryKey(),
  name: varchar('name', { length: 100 }).notNull(),
  email: varchar('email', { length: 255 }).unique().notNull(),
  age: integer('age'),
  isActive: boolean('is_active').default(true),
  createdAt: timestamp('created_at').defaultNow(),
});

// Usage — feels like writing SQL!
const { eq, gt, and } = require('drizzle-orm');

// SELECT * FROM users WHERE age > 18 AND is_active = true
const result = await db.select().from(users).where(
  and(gt(users.age, 18), eq(users.isActive, true))
);
```

### 22.3 ORM Comparison

| Feature | Prisma | Drizzle | Sequelize |
|---|---|---|---|
| **Learning Curve** | Low | Medium | Medium |
| **Type Safety** | Excellent | Excellent | Good |
| **Schema** | Own schema file | JS/TS code | JS/TS code |
| **Migrations** | Built-in | Built-in | Built-in |
| **Raw SQL** | `$queryRaw` | Built-in | `sequelize.query()` |
| **Performance** | Good | Best | Good |
| **Popularity** | Most popular | Growing fast | Mature, large community |
| **Similar to** | Mongoose | — | — |

---

<a id="module-23--mongodb-vs-postgresql-cheat-sheet"></a>

## Module 23 — MongoDB vs PostgreSQL Cheat Sheet

### Quick Reference Translation Table

| Operation | MongoDB | PostgreSQL |
|---|---|---|
| **Create DB** | `use mydb` (auto-creates) | `CREATE DATABASE mydb;` |
| **Drop DB** | `db.dropDatabase()` | `DROP DATABASE mydb;` |
| **Show DBs** | `show dbs` | `\l` |
| **Switch DB** | `use mydb` | `\c mydb` |
| **Create Collection/Table** | Auto-created on insert | `CREATE TABLE users (...)` |
| **Show Collections/Tables** | `show collections` | `\dt` |
| **Insert One** | `db.users.insertOne({...})` | `INSERT INTO users (...) VALUES (...)` |
| **Insert Many** | `db.users.insertMany([...])` | `INSERT INTO users VALUES (...), (...), (...)` |
| **Find All** | `db.users.find()` | `SELECT * FROM users` |
| **Find with Filter** | `db.users.find({ age: 25 })` | `SELECT * FROM users WHERE age = 25` |
| **Find One** | `db.users.findOne({ _id: id })` | `SELECT * FROM users WHERE id = 1 LIMIT 1` |
| **Select Fields** | `db.users.find({}, { name: 1 })` | `SELECT name FROM users` |
| **Count** | `db.users.countDocuments()` | `SELECT COUNT(*) FROM users` |
| **Sort** | `.sort({ name: 1 })` | `ORDER BY name ASC` |
| **Limit** | `.limit(10)` | `LIMIT 10` |
| **Skip** | `.skip(20)` | `OFFSET 20` |
| **Update One** | `updateOne({}, { $set: {} })` | `UPDATE users SET ... WHERE ...` |
| **Update Many** | `updateMany({}, { $set: {} })` | `UPDATE users SET ... WHERE ...` |
| **Increment** | `{ $inc: { views: 1 } }` | `SET views = views + 1` |
| **Delete One** | `deleteOne({ _id: id })` | `DELETE FROM users WHERE id = 1` |
| **Delete Many** | `deleteMany({ age: { $lt: 18 } })` | `DELETE FROM users WHERE age < 18` |
| **Drop Collection/Table** | `db.users.drop()` | `DROP TABLE users` |
| **Create Index** | `createIndex({ email: 1 })` | `CREATE INDEX idx ON users(email)` |
| **Unique Index** | `createIndex({email:1}, {unique:true})` | `CREATE UNIQUE INDEX idx ON users(email)` |
| **Aggregation** | Aggregation Pipeline | `GROUP BY`, `HAVING`, Window Functions |
| **Join/Lookup** | `$lookup` stage | `JOIN` (much more powerful) |
| **Unwind** | `$unwind` | `unnest()` or `jsonb_array_elements()` |
| **Transactions** | `session.withTransaction()` | `BEGIN; ... COMMIT;` |
| **Schema Validation** | JSON Schema validators | `CREATE TABLE` with constraints |
| **Text Search** | `$text` + text index | `tsvector` + `tsquery` |
| **Geospatial** | `$near`, `$geoWithin` | PostGIS extension |
| **Change Streams** | `collection.watch()` | `LISTEN` / `NOTIFY` |
| **TTL** | TTL indexes | No built-in (use pg_cron + DELETE) |

---

<a id="module-24--real-world-project-ideas"></a>

## Module 24 — Real-World Project Ideas

### 🟢 Beginner Projects

1. **Todo App** — Basic CRUD with users and tasks
   - Practice: Tables, foreign keys, CRUD, basic queries

2. **Blog Platform** — Users, posts, comments, tags
   - Practice: One-to-many, many-to-many, joins

3. **Library Management** — Books, authors, borrowers
   - Practice: Relationships, constraints, transactions

### 🟡 Intermediate Projects

4. **E-Commerce Store** — Products, categories, orders, reviews, users
   - Practice: Complex joins, aggregations, transactions, indexes

5. **Social Media API** — Users, posts, comments, likes, follows, feed
   - Practice: Many-to-many, self-joins, pagination, window functions

6. **Job Board** — Companies, job listings, applications, resumes
   - Practice: Full-text search, JSONB, filtering, sorting

### 🔴 Advanced Projects

7. **Analytics Dashboard** — Event tracking, real-time stats, time-series data
   - Practice: Window functions, materialized views, partitioning

8. **Multi-Tenant SaaS** — Organizations, users, permissions, audit logs
   - Practice: Row-level security, roles, triggers, functions

9. **Real-Time Chat** — Users, rooms, messages, read receipts
   - Practice: LISTEN/NOTIFY, triggers, JSONB, timestamps

10. **Financial System** — Accounts, transactions, ledger, reporting
    - Practice: ACID transactions, stored procedures, decimal precision

---

<a id="module-25--resources--whats-next"></a>

## Module 25 — Resources & What's Next

### 📚 Official Documentation
- [PostgreSQL Official Docs](https://www.postgresql.org/docs/current/) — the best and most comprehensive resource
- [PostgreSQL Wiki](https://wiki.postgresql.org/)
- [PostgreSQL Tutorial](https://www.postgresqltutorial.com/) — beginner-friendly tutorials

### 🎓 Free Courses & Tutorials
- [Prisma's Data Guide](https://www.prisma.io/dataguide) — excellent introduction to databases and PostgreSQL
- [SQLBolt](https://sqlbolt.com/) — interactive SQL lessons
- [SQL Zoo](https://sqlzoo.net/) — practice SQL with exercises
- [PostgreSQL Exercises](https://pgexercises.com/) — focused PostgreSQL practice

### 📖 Books
- *"The Art of PostgreSQL"* by Dimitri Fontaine — excellent for developers
- *"PostgreSQL: Up and Running"* by Regina Obe — practical guide
- *"Designing Data-Intensive Applications"* by Martin Kleppmann — understand database internals

### 🧰 Tools
- **pgAdmin** — Official GUI
- **DBeaver** — Free universal database tool
- **Prisma Studio** — If using Prisma ORM
- **pg_stat_statements** — Monitor query performance
- **pgHero** — Performance dashboard for PostgreSQL

### 🗺️ Learning Path After This Course

```
You Are Here ──────────────────────────────────────────────►
                                                            
[Installation] → [SQL Basics] → [Joins & Aggregation] → [Indexes]
                                                            │
                                                            ▼
[Advanced SQL] → [Functions & Triggers] → [Performance Tuning]
                                                            │
                                                            ▼
[Node.js Integration] → [ORM (Prisma)] → [Real Project] → [Deploy]
                                                            │
                                                            ▼
                                              [PostgreSQL Mastery!] 🐘
```

### 🏆 Tips for Success

1. **Practice daily** — Even 30 minutes of SQL practice makes a huge difference
2. **Use psql** — The command line builds muscle memory and deeper understanding
3. **Read EXPLAIN output** — Understanding query plans makes you 10x more effective
4. **Build a real project** — Theory without practice is forgotten quickly
5. **Don't abandon MongoDB** — Use the right tool for the right job. Some projects benefit from MongoDB, others from PostgreSQL, and many use both!
6. **Think in tables** — When you see data, practice mentally designing the schema with proper normalization
7. **Write raw SQL first** — Before using an ORM, make sure you understand the SQL it generates

---

> **🐘 Congratulations!** You now have a complete roadmap from PostgreSQL zero to hero. Start at Module 1, work through each module with hands-on practice, and you'll be writing complex SQL queries and building production-ready applications in no time.
>
> Remember: The best way to learn a database is to **build something real with it**. Pick a project from Module 24 and start coding!

---

*Last updated: July 2026*
