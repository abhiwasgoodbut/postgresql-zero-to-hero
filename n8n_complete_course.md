# ⚡ n8n Workflow Automation — Zero to Hero Course Guide

> **Audience**: Developers & beginners who want to master n8n on `localhost` from scratch.
> **Prerequisites**: Basic understanding of JSON, databases (PostgreSQL / MongoDB), and web concepts (APIs / Webhooks).
> **Setup Target**: 100% Free Self-Hosted on `localhost:5678`.

---

## 📑 Table of Contents

1. [Module 1 — What is n8n & Why Self-Host on Localhost?](#module-1--what-is-n8n--why-self-host-on-localhost)
2. [Module 2 — Installation & Localhost Setup (Windows, Mac, Docker)](#module-2--installation--localhost-setup)
3. [Module 3 — n8n Core Concepts: How n8n Thinks](#module-3--n8n-core-concepts-how-n8n-thinks)
4. [Module 4 — Data Flow & Expressions ($json, JavaScript)](#module-4--data-flow--expressions)
5. [Module 5 — Logic & Flow Control (IF, Switch, Loops)](#module-5--logic--flow-control)
6. [Module 6 — Webhooks & HTTP Request Node (Connecting Any API)](#module-6--webhooks--http-request-node)
7. [Module 7 — Database Automation: PostgreSQL & MongoDB in n8n](#module-7--database-automation-postgresql--mongodb)
8. [Module 8 — AI Workflows in n8n (AI Agents, Gemini & OpenAI)](#module-8--ai-workflows-in-n8n)
9. [Module 9 — 5 Complete Real-World Projects (Step-by-Step)](#module-9--5-complete-real-world-projects)
   - [Project 1: E-Commerce Webhook → PostgreSQL Logger → Telegram Alert](#project-1-ecommerce-webhook--postgresql-logger--telegram-alert)
   - [Project 2: Daily Database Health Check & HTML Email Report](#project-2-daily-database-health-check--html-email-report)
   - [Project 3: AI Lead Qualifier & Sentiment Classifier into Database](#project-3-ai-lead-qualifier--sentiment-classifier-into-database)
   - [Project 4: MongoDB to PostgreSQL Data Migration & Sync Pipeline](#project-4-mongodb-to-postgresql-data-migration--sync-pipeline)
   - [Project 5: Automated Alert System with Error Trigger & Rollback](#project-5-automated-alert-system-with-error-trigger--rollback)
10. [Module 10 — Localhost Secrets: Webhook Tunneling (ngrok/n8n Tunnel), Backups & Production](#module-10--localhost-secrets-tunneling-backups--production)

---

<a id="module-1--what-is-n8n--why-self-host-on-localhost"></a>

## Module 1 — What is n8n & Why Self-Host on Localhost?

### 1.1 What is n8n?
**n8n** (pronounced *n-eight-n*, short for "nodemation") is an open-source, node-based workflow automation tool. Think of it as a **free, self-hosted, infinitely customizable alternative to Zapier or Make.com**.

Instead of writing hundreds of lines of boilerplate glue code in Python or Node.js to connect APIs, webhooks, databases, and AI models, you visually design workflows while retaining full coding power with JavaScript/Python.

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│ Webhook / API│ ──► │  PostgreSQL  │ ──► │   AI Agent   │ ──► │   Discord /  │
│    Trigger   │     │ (Fetch Data) │     │ (Summarize)  │     │   Telegram   │
└──────────────┘     └──────────────┘     └──────────────┘     └──────────────┘
```

### 1.2 n8n vs Zapier vs Make (Integromat)

| Feature | n8n (Self-Hosted) | Zapier | Make.com |
|---|---|---|---|
| **Cost** | **$0 (100% Free)** | $20 - $500+/mo | $9 - $300+/mo |
| **Execution Limits** | **Unlimited** | Limited by tier | Limited by operations |
| **Data Privacy** | Stays on your machine / server | On cloud servers | On cloud servers |
| **Database Access** | Direct access to `localhost` PostgreSQL / Mongo | Requires public IP / tunnels | Requires public IP / tunnels |
| **Custom Code** | Full JavaScript / Python support | Very limited | Limited |
| **AI Capabilities** | Native LangChain AI Agent nodes | Basic | Basic |

---

<a id="module-2--installation--localhost-setup"></a>

## Module 2 — Installation & Localhost Setup

You can run n8n locally using either **npm (Node.js)** or **Docker**.

---

### Option A: Using npm (Fastest & Simplest for Beginners)

If you already have **Node.js** installed (version 18 or 20+):

#### 1. Install n8n globally:
```bash
npm install n8n -g
```

#### 2. Start n8n:
```bash
n8n
```

#### 3. Open in Browser:
Visit **`http://localhost:5678`**

> **Tip**: First time launching will ask you to set up an admin account (Email & Password). This is stored strictly locally on your machine.

---

### Option B: Using Docker (Recommended for Isolated Environments)

If you have Docker Desktop installed:

```bash
docker run -it --rm \
  --name n8n \
  -p 5678:5678 \
  -v ~/.n8n:/home/node/.n8n \
  docker.n8n.io/n8nio/n8n
```

- `-p 5678:5678`: Maps port `5678` to your host machine.
- `-v ~/.n8n:...`: Preserves your workflows, credentials, and settings across restarts.

---

### Option C: Running with Built-In Tunnel (For Receiving Public Webhooks)

When working on `localhost`, external services (like Stripe, GitHub, Shopify) cannot send webhooks to `http://localhost:5678`.

n8n includes a free built-in tunnel:

```bash
n8n start --tunnel
```
This generates a public URL like `https://funny-cat-42.hooks.n8n.cloud/webhook/...` that routes directly to your localhost!

---

<a id="module-3--n8n-core-concepts-how-n8n-thinks"></a>

## Module 3 — n8n Core Concepts: How n8n Thinks

### 3.1 Key Terminology

- **Workflow**: The canvas containing interconnected nodes.
- **Node**: A single block that performs an action (e.g., *Postgres Query*, *Send Email*, *IF Condition*).
- **Trigger Node**: The starting node that kicks off the workflow (e.g., *Schedule/Cron*, *Webhook*, *On App Event*).
- **Action Node**: Executes a task (e.g., *Insert into DB*, *HTTP Request*).
- **Execution**: A single run of a workflow with input and output data.

### 3.2 The Core Data Structure of n8n: Array of JSON Objects

Every node in n8n passes data to the next node as a **List of Items** (Array of Objects with a `json` key):

```json
[
  {
    "json": {
      "id": 1,
      "name": "Alex Rivera",
      "email": "alex@gmail.com",
      "total_spent": 1248.00
    }
  },
  {
    "json": {
      "id": 2,
      "name": "Priya Sharma",
      "email": "priya@outlook.com",
      "total_spent": 1099.00
    }
  }
]
```

> **Crucial Rule**: If an upstream node outputs 5 items, subsequent action nodes (like *Send Email* or *Postgres Insert*) will automatically run **5 times (once for each item)** unless you aggregate them!

---

<a id="module-4--data-flow--expressions"></a>

## Module 4 — Data Flow & Expressions

### 4.1 Expressions Syntax

In any node field, you can type `{{ ... }}` to reference values from previous nodes:

| Expression | Meaning |
|---|---|
| `{{ $json.email }}` | Reads the `email` property of the current item |
| `{{ $json.user.address.city }}` | Reads nested object properties |
| `{{ $('Webhook').item.json.body.order_id }}` | Reads data specifically from the node named `'Webhook'` |
| `{{ $now.format('YYYY-MM-DD') }}` | Current formatted date |
| `{{ $json.price * 1.18 }}` | Mathematical calculations inline |

---

### 4.2 The Code Node (JavaScript / Python)

When built-in nodes aren't enough, drop in a **Code Node** to execute custom JS:

```javascript
// Run once for all items
for (const item of $input.all()) {
  // Add a calculated field
  item.json.tax = Number((item.json.price * 0.18).toFixed(2));
  item.json.total = item.json.price + item.json.tax;
  item.json.fullName = item.json.firstName + ' ' + item.json.lastName;
}

return $input.all();
```

---

<a id="module-5--logic--flow-control"></a>

## Module 5 — Logic & Flow Control

### 5.1 The `IF` Node (Branching)
Splits workflow into **true** and **false** outputs based on conditions:
- Value `{{ $json.total_amount }}` > `1000`
- String `{{ $json.status }}` equals `'delivered'`
- Boolean `{{ $json.is_premium }}` is true

### 5.2 The `Switch` Node (Multi-Way Routing)
Routes execution along different paths based on matching rules (e.g., Order Status: *pending*, *shipped*, *delivered*, *cancelled*).

### 5.3 The `Looping / Split In Batches` Node
Processes large sets of items in controlled chunks (e.g., send 50 emails at a time to prevent rate-limiting).

---

<a id="module-6--webhooks--http-request-node"></a>

## Module 6 — Webhooks & HTTP Request Node

### 6.1 Webhook Node (Receiving Data)
1. Drag the **Webhook** node onto canvas.
2. Select HTTP Method: `POST` or `GET`.
3. Choose Path: `ecom-order`.
4. Copy the **Test URL** or **Production URL**.
5. When a POST request hits this URL, the workflow triggers instantly with the request payload in `$json.body`!

### 6.2 HTTP Request Node (Calling External APIs)
Can make any `GET`, `POST`, `PUT`, `DELETE` request:
- **Authentication**: Header Auth, Bearer Token, OAuth2, Basic Auth
- **Body Content**: JSON, Form-data, Raw
- Perfect for Weather APIs, Stripe, WhatsApp Cloud API, custom backend routes.

---

<a id="module-7--database-automation-postgresql--mongodb"></a>

## Module 7 — Database Automation: PostgreSQL & MongoDB

### 7.1 Connecting PostgreSQL on Localhost

1. In n8n, add a **PostgreSQL** node.
2. Under **Credential to connect with**, click **Create New Credential**:
   - **Host**: `localhost` (or `host.docker.internal` if n8n is inside Docker)
   - **Database**: `ecom_db` (or `shopdb`)
   - **User**: `postgres`
   - **Password**: `your_postgres_password`
   - **Port**: `5432`
   - **SSL**: `disable` (for local)
3. Test connection → ✅ Connected!

### 7.2 Core PostgreSQL Operations in n8n

- **Execute Query**: Run any raw SQL query (`SELECT`, `JOIN`, `UPDATE`, `INSERT`)
- **Insert**: Insert mapped JSON keys directly into table columns without writing SQL
- **Update**: Update matching rows based on Primary Key

---

<a id="module-8--ai-workflows-in-n8n"></a>

## Module 8 — AI Workflows in n8n

n8n has full **LangChain & AI Agent** integration:

- **AI Agent Node**: Autonomous reasoning agent
- **Language Models**: Google Gemini, OpenAI GPT-4o, Anthropic Claude, Local Ollama
- **Memory**: Window Buffer Memory, Postgres Chat Memory
- **Tools**: Give the AI access to database queries, calculators, custom HTTP requests, Google Search!

---

<a id="module-9--5-complete-real-world-projects"></a>

## Module 9 — 5 Complete Real-World Projects

---

### Project 1: E-Commerce Webhook → PostgreSQL Logger → Telegram Alert

**Goal**: When an order is placed from a frontend / app:
1. Receive order data via Webhook.
2. Insert order into PostgreSQL `orders` and `order_items` tables.
3. If order total > $1,000, send an immediate VIP alert to a Telegram channel!

```
[ Webhook Trigger ]
        │
        ▼
[ PostgreSQL: Insert Order ]
        │
        ▼
[ IF total_amount > 1000 ]
      │             │
   (TRUE)        (FALSE)
      │             │
      ▼             ▼
[ Telegram ]    [ No Action ]
(VIP Alert)
```

#### Step-by-Step Implementation:
1. **Webhook Node**:
   - Method: `POST`
   - Path: `new-order`
   - Sample payload sent via Postman/cURL:
     ```json
     {
       "user_id": 1,
       "total_amount": 1248.00,
       "status": "delivered",
       "items": [
         { "product_id": 1, "quantity": 1, "unit_price": 999.00 },
         { "product_id": 7, "quantity": 1, "unit_price": 249.00 }
       ]
     }
     ```
2. **Postgres Node (Insert Order)**:
   - Operation: `Execute Query`
   - Query:
     ```sql
     INSERT INTO orders (user_id, status, total_amount)
     VALUES ({{ $json.body.user_id }}, '{{ $json.body.status }}', {{ $json.body.total_amount }})
     RETURNING id, user_id, total_amount;
     ```
3. **IF Node**:
   - Condition: `{{ $json.total_amount }}` > `1000`
4. **Telegram Node (True Branch)**:
   - Chat ID: `YOUR_CHAT_ID`
   - Text: `🚨 *VIP Order Placed!* \nOrder #{{ $json.id }} for ${{ $json.total_amount }}`

---

### Project 2: Daily Database Health Check & HTML Email Report

**Goal**: Every morning at 9:00 AM:
1. Run analytics query in PostgreSQL.
2. Calculate total daily revenue, new orders, and low-stock items.
3. Build a styled HTML email and send to the management team.

```
[ Schedule Trigger: 9 AM ]
            │
            ▼
[ Postgres: Run Stats Query ]
            │
            ▼
[ Code Node: Format HTML ]
            │
            ▼
[ Send Email (Gmail/SMTP) ]
```

#### SQL Query for Stats Node:
```sql
SELECT 
    COUNT(o.id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_revenue,
    (SELECT COUNT(*) FROM products WHERE stock < 20) AS low_stock_count
FROM orders o
WHERE o.order_date >= CURRENT_DATE - INTERVAL '1 day';
```

---

### Project 3: AI Lead Qualifier & Sentiment Classifier into Database

**Goal**: Automatically classify incoming user inquiries/reviews using Google Gemini or OpenAI and store sentiment score into PostgreSQL.

1. **Webhook**: Receives review comment.
2. **AI Agent / OpenAI Node**:
   - Prompt: `Classify the sentiment of this review as Positive, Neutral, or Negative and extract key topics: "{{ $json.body.comment }}"`
3. **PostgreSQL Node**:
   - Updates `reviews` table with AI classification tag.

---

### Project 4: MongoDB to PostgreSQL Data Migration & Sync Pipeline

**Goal**: Transition data from MongoDB collection to PostgreSQL relational tables automatically!

1. **Schedule / Manual Trigger**.
2. **MongoDB Node**: `Find` operation to fetch documents.
3. **Code Node**: Flattens nested MongoDB BSON/JSON fields to match PostgreSQL columns.
4. **PostgreSQL Node**: Batch `INSERT ... ON CONFLICT DO UPDATE`.

---

### Project 5: Automated Alert System with Error Trigger & Rollback

**Goal**: When any database or API workflow fails, catch the error and dispatch an alert with error stack trace to Discord / Slack.

1. Create a workflow named `Global Error Handler`.
2. Add **Error Trigger** node.
3. Connect to **Discord / Slack / Telegram** webhook.
4. In main workflows: Open Settings → Set **Error Workflow** to `Global Error Handler`.

---

<a id="module-10--localhost-secrets-tunneling-backups--production"></a>

## Module 10 — Localhost Secrets: Tunneling, Backups & Production

### 10.1 Webhook Tunneling Options (Testing webhooks locally)

1. **Built-in n8n Tunnel**:
   ```bash
   n8n start --tunnel
   ```
2. **Using ngrok**:
   ```bash
   ngrok http 5678
   ```
   Set webhook URL in n8n settings to your ngrok forwarding domain.

### 10.2 Backing up Your n8n Workflows
All your workflows and credentials are saved locally in `~/.n8n/` (or `%USERPROFILE%\.n8n` on Windows).

**Export all workflows via CLI**:
```bash
n8n export:workflow --all --output=my_workflows.json
```

**Import workflows back**:
```bash
n8n import:workflow --input=my_workflows.json
```

---

## 🚀 Quick Reference: n8n Expression Cheat Sheet

| Task | Syntax |
|---|---|
| Access field from current node | `{{ $json.myField }}` |
| Access field from specific node | `{{ $('NodeName').item.json.myField }}` |
| Convert to Number | `{{ Number($json.amount) }}` |
| Date formatting | `{{ DateTime.now().toFormat('yyyy-MM-dd') }}` |
| Ternary Condition | `{{ $json.age >= 18 ? 'Adult' : 'Minor' }}` |
| Array mapping | `{{ $json.items.map(i => i.title).join(', ') }}` |

---

> 💡 **Next Step**: Start n8n (`n8n` in terminal), open `http://localhost:5678`, and build **Project 1** connecting to your `ecom_db` database!
