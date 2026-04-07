# Festival Payment API - Live Coding Task

Welcome! You are taking over a backend API for a Festival Payment System. The previous team left the project in a functional "MVP" state, but there are concerns regarding its reliability and performance as we scale.

## Your Goal
Your task is to prepare the system for a high-traffic festival. We value the **"Rails Way"** (Fat Models, Thin Controllers) and expect clean, maintainable ActiveRecord-based solutions.

## Getting Started

### Option 1: Using Docker (Recommended)
```bash
# Build and start the app
docker-compose up --build

# In a separate terminal, seed the database
docker-compose exec web bin/rails db:seed

# Run the reproduction script
docker-compose exec web ./bin/setup_alice_scenario

# Run tests
docker-compose exec web bundle exec rspec

# Enter Rails Console
docker-compose exec web bin/rails console
```

### Option 2: Local Ruby
```bash
# Ensure Ruby 3.4.3 is installed
bundle install
bin/rails db:prepare db:seed
```

## Tasks

### 1. System Audit & Refactoring
Perform a quick code review of the current implementation. Identify any potential issues regarding **data integrity**, **security**, or **architectural consistency**. Refactor the core flows to meet production standards.

### 2. Performance Review
The event organisers have complained that some endpoints are becoming sluggish. Identify the bottleneck in the recent payments report and propose/implement a fix.

### 3. Bug Investigation
A festival participant has filed the following support ticket:

**Subject:** Cannot make a payment — "insufficient funds" error but I have credits

> Hi, I've been buying food and drinks all day with no issues. Now I'm trying to pay for one last meal (5.90 credits) and the app is telling me I don't have enough funds. My balance clearly shows I should have exactly enough. Please help!
> — Alice Johnson (alice@festival.com)

**Your task:**
1. Use the setup script to prepare Alice's data.
2. Investigate why Alice's next 5.90 payment fails (reproduce and find the root cause).
3. Propose and implement a fix.

**Reproduction command:**
```bash
# First ensure the database is seeded
bin/rails db:seed

# Prepare the data for Alice
./bin/setup_alice_scenario

# Now enter the console to investigate and reproduce the final failing payment
bin/rails console
```

### 4. New Feature: Merchant Income Report
Add an endpoint that returns the total income for a specific `Merchant` within a given date range (`start_date` to `end_date`).

---
*Note: You are encouraged to use AI coding assistants to speed up your workflow.*

---

# 🛑 Interviewer's Private Guide (Evaluation Criteria)

**Note to Recruiter:** This section is for your eyes only. It contains the "answers" to the tasks.

## Goal of the Task
Evaluate the candidate's seniority in:
1. **Auditing & Code Review:** Can they find the race condition and N+1 queries without hints?
2. **"Rails Way" Thinking:** Do they instinctively move logic to the Model and use standard ActiveRecord patterns (Transactions, Locking)?
3. **Data Integrity:** Do they understand database transactions and why `Float` is dangerous for money?

---

### Task 1: Audit (Target: `PaymentsController#create`)
*   **The Bug:** A critical **Race Condition**. Two concurrent requests can read the same balance and proceed, leading to double-spending. Also, if `Payment.create!` fails, the user already lost their balance (no transaction rollback).
*   **The Senior Fix:** 
    1. Moves logic to Model (e.g., `User#pay!` or `Payment.process!`).
    2. Wraps everything in a **Database Transaction**.
    3. Uses **Pessimistic Locking** (`account.with_lock`) to ensure atomicity.
*   **Idiomatic "Rails Way" Solution:**
    ```ruby
    # In Payment model or User model
    def self.process!(user:, merchant:, amount:)
      transaction do
        user.account.with_lock do
          raise "Insufficient funds" if user.account.balance < amount
          user.account.decrement!(:balance, amount)
          create!(user: user, merchant: merchant, amount: amount)
        end
      end
    end
    ```
*   **Look for:** Do they notice that model validations (`greater_than: 0`) don't prevent race conditions?

### Task 2: Performance (Target: `OrganisersController#recent_payments`)
*   **The Bug:** **N+1 Query** trap in `app/views/organisers/recent_payments.json.jbuilder`. Accessing `payment.user` and `payment.merchant` for each record.
*   **The Senior Fix:** Adds `.includes(:user, :merchant)` to the query in the controller.
*   **Bonus:** Discusses how to detect this in logs (watching for multiple SELECTs) or with `Rack::MiniProfiler`.

### Task 3: Bug Investigation (Target: `Account#balance` Float Type)
*   **The Bug:** **Floating Point Precision Error**. Using `float` for currency calculation leads to `14.7 * 3 = 44.099999...` which makes `50.0 - 44.1 = 5.899999...` (less than `5.9`).
*   **The Senior Fix:** Changes the database column type to **Decimal** (with precision/scale) or **Integer** (cents).
*   **Red Flag:** Tries to fix it with `.round(2)` or `.to_f.to_d` without changing the underlying storage type. This doesn't fix the source of truth.

### Task 4: New Feature (Income Report)
*   **The Target:** Implement efficiently using SQL aggregation.
*   **The Senior Fix:** `merchant.payments.where(created_at: range).sum(:amount)`.
*   **Bonus:** Mentions adding a database index on `merchant_id` and `created_at` for better performance.

### Senior-Level Probing Questions
*   "What is the difference between `Pessimistic` and `Optimistic` locking? Which one is better here?"
*   "How would you handle idempotency if the mobile app sends the same request twice?"
*   "How would you scale this for a 'Hot Merchant' (100+ payments/sec) where locking the merchant record becomes a bottleneck?" (Wait-free counters, buffering, etc.)
*   "Why is `after_commit` better than `after_create` for sending emails or starting background jobs?"
