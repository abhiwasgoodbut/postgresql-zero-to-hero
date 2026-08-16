# 🐘 PostgreSQL — Zero to Hero

A comprehensive PostgreSQL course designed for developers transitioning from MongoDB. Go from zero knowledge to writing complex queries, building real databases, and integrating with Node.js.

---

## 📁 What's Inside

| File | Description |
|---|---|
| [`postgresql_complete_course.md`](./postgresql_complete_course.md) | 📖 **Full Course Guide** — 25 detailed modules covering theory, syntax, and examples |
| [`postgresql_practice_workbook.md`](./postgresql_practice_workbook.md) | ✍️ **Hands-On Workbook** — 94 exercises where you write every query yourself |

---

## 🚀 Getting Started

### 1. Install PostgreSQL

**Windows:**
```powershell
# Download installer from https://www.postgresql.org/download/windows/
# Or use Chocolatey:
choco install postgresql
```

**macOS:**
```bash
brew install postgresql@17
brew services start postgresql@17
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt update
sudo apt install postgresql postgresql-contrib
sudo systemctl start postgresql
sudo systemctl enable postgresql
```

**Docker:**
```bash
docker run --name my-postgres \
  -e POSTGRES_PASSWORD=mysecretpassword \
  -e POSTGRES_USER=myuser \
  -e POSTGRES_DB=mydb \
  -p 5432:5432 \
  -d postgres:latest
```

### 2. Verify Installation

```bash
psql --version
```

### 3. Connect to PostgreSQL

```bash
psql -U postgres
```

### 4. Start Learning

Open [`postgresql_complete_course.md`](./postgresql_complete_course.md) and start with **Module 1**.

Once you've read a module, open [`postgresql_practice_workbook.md`](./postgresql_practice_workbook.md) and complete the matching exercises by writing SQL in the blank code blocks.

---

## 📚 Course Modules

| # | Module | Topics |
|---|---|---|
| 1 | What is PostgreSQL & Why Learn It? | Relational vs Document, terminology translation |
| 2 | Installation & Setup | Windows, macOS, Linux, Docker |
| 3 | psql & pgAdmin | CLI commands, GUI tools |
| 4 | SQL Fundamentals | DDL, DML, DCL, TCL, syntax rules |
| 5 | Data Types | Numeric, text, boolean, date/time, UUID, JSONB, arrays, enums |
| 6 | Table Design & Constraints | PK, FK, UNIQUE, CHECK, NOT NULL, relationships |
| 7 | CRUD Operations | INSERT, SELECT, UPDATE, DELETE with RETURNING |
| 8 | Filtering, Sorting & Pagination | WHERE, ORDER BY, LIMIT, OFFSET, cursor pagination |
| 9 | JOINs | INNER, LEFT, RIGHT, FULL OUTER, CROSS, SELF, multi-table |
| 10 | Aggregate Functions & GROUP BY | COUNT, SUM, AVG, HAVING, window functions |
| 11 | Subqueries & CTEs | Nested queries, EXISTS, recursive CTEs |
| 12 | Indexes & Performance | B-tree, GIN, GiST, BRIN, EXPLAIN ANALYZE |
| 13 | Views & Materialized Views | Virtual tables, cached query results |
| 14 | Transactions & ACID | BEGIN, COMMIT, ROLLBACK, savepoints, isolation levels |
| 15 | Functions & Stored Procedures | Custom functions, PL/pgSQL |
| 16 | Triggers | Event-driven logic, audit trails |
| 17 | JSON/JSONB | Operators, querying, modifying, indexing JSON |
| 18 | User Management & Permissions | Roles, GRANT, REVOKE, row-level security |
| 19 | Backup, Restore & Maintenance | pg_dump, pg_restore, VACUUM, ANALYZE |
| 20 | Advanced Topics | Full-text search, partitioning, LISTEN/NOTIFY, extensions |
| 21 | PostgreSQL with Node.js | pg driver, connection pooling, Express.js API |
| 22 | ORMs | Prisma, Drizzle, Sequelize |
| 23 | MongoDB vs PostgreSQL Cheat Sheet | Side-by-side command translation |
| 24 | Real-World Project Ideas | 10 projects from beginner to advanced |
| 25 | Resources & What's Next | Docs, books, tools, learning path |

---

## ✍️ Practice Workbook Overview

The workbook builds a **complete e-commerce database** (`shopdb`) from scratch through **94 exercises**:

```
shopdb
├── users           (customers)
├── categories      (product categories)
├── products        (items for sale)
├── orders          (customer orders)
├── order_items     (products in each order)
└── reviews         (product reviews)
```

**Exercise breakdown:**

| Section | Exercises | Skills Practiced |
|---|---|---|
| Setup & First Commands | 6 | psql, CREATE DATABASE |
| Creating Tables | 7 | CREATE TABLE, constraints, foreign keys |
| INSERT Data | 7 | Single/bulk inserts, RETURNING, constraint testing |
| SELECT Queries | 4 | Basic reads, aliases, DISTINCT, COUNT |
| WHERE Filtering | 7 | Comparisons, LIKE, BETWEEN, NULL, LIMIT/OFFSET |
| JOINs | 7 | INNER, LEFT, multi-table, finding orphan records |
| Aggregates & GROUP BY | 6 | SUM, AVG, GROUP BY, HAVING |
| Subqueries & CTEs | 6 | Nested queries, EXISTS, multiple CTEs |
| UPDATE & DELETE | 5 | Bulk updates, UPSERT, RETURNING |
| Indexes & Performance | 5 | EXPLAIN ANALYZE, CREATE INDEX |
| Views | 3 | CREATE VIEW, querying views |
| Transactions | 3 | BEGIN/COMMIT/ROLLBACK, savepoints |
| Functions | 2 | Custom PL/pgSQL functions |
| Triggers | 2 | Auto-timestamps, stock management |
| JSONB | 4 | Add, query, modify JSON data |
| Window Functions | 4 | ROW_NUMBER, RANK, running totals, LAG/LEAD |
| Advanced Queries | 5 | Revenue reports, recommendations |
| ALTER Table | 4 | Add/rename/drop columns, constraints |
| User Management | 2 | Roles, GRANT permissions |
| Backup & Cleanup | 4 | pg_dump, VACUUM, table sizes |
| **Final Boss Challenges** | **3** | Complex reports, materialized views, full-text search |
| **Total** | **94** | |

---

## 🛠️ Recommended Tools

| Tool | Description | Install |
|---|---|---|
| **psql** | CLI tool (comes with PostgreSQL) | Included |
| **pgAdmin 4** | Official GUI | Included with installer |
| **DBeaver** | Universal DB tool | [dbeaver.io](https://dbeaver.io/) |
| **TablePlus** | Modern DB GUI | [tableplus.com](https://tableplus.com/) |

---

## 📖 How to Use This Repo

```bash
# Clone the repo
git clone https://github.com/abhiwasgoodbut/postgresql-zero-to-hero.git

# Open in VS Code
cd postgresql-zero-to-hero
code .

# Read the course guide → practice in the workbook → repeat!
```

---

## 👤 Author

Made with ❤️ for developers transitioning from MongoDB to PostgreSQL.

## 📄 License

This project is open source and available for anyone to learn from.
