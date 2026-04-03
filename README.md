# Festival Payment API - Live Coding Task

Welcome! You are taking over a backend API for a Festival Payment System. The previous team left the project in a functional "MVP" state, but there are concerns regarding its reliability and performance as we scale.

## Your Goal
Your task is to prepare the system for a high-traffic festival. We value the **"Rails Way"** (Fat Models, Thin Controllers) and expect clean, maintainable ActiveRecord-based solutions.

## Tasks

### 1. System Audit & Refactoring
Perform a quick code review of the current implementation. Identify any potential issues regarding **data integrity**, **security**, or **architectural consistency**. Refactor the core flows to meet production standards.

### 2. Performance Review
The event organisers have complained that some endpoints are becoming sluggish even with a small amount of data. Identify the bottleneck and propose/implement a fix.

### 3. New Feature: Merchant Income Report
The organisers need a way to track merchant performance. Add an endpoint that returns the total income (`amount_cents`) for a specific `Merchant` within a given date range (`start_date` to `end_date`).

---
*Note: You are encouraged to use AI coding assistants to speed up your workflow.*

---

# 🛑 Interviewer's Private Guide (Evaluation Criteria)

**Note to Recruiter:** This section is for your eyes only. It contains the "answers" to the tasks.

## Goal of the Task
Evaluate the candidate's seniority in:
1. **Auditing & Code Review:** Can they find the race condition and N+1 queries without hints?
2. **"Rails Way" Thinking:** Do they instinctively move logic to the Model and use standard ActiveRecord patterns?
3. **Data Integrity:** Do they understand database transactions and locking mechanisms?

---

### Task 1: Audit & Refactoring (Target: `PaymentsController#create`)
*   **The Bug:** A critical **Race Condition**. Two concurrent requests can read the same balance and bypass the `balance_cents >= amount` check.
*   **The Senior Fix:** Moves logic to `User#pay!` or `Payment.process!`, wraps it in a **transaction**, and uses **pessimistic locking** (`user.with_lock`).
*   **Look for:** Do they mention that model validations (`greater_than: 0`) don't prevent race conditions in concurrent environments?

### Task 2: Performance Review (Target: `OrganisersController#recent_payments`)
*   **The Bug:** Classic **N+1 Query** trap. Accessing `payment.user.name` and `payment.merchant.name` in a loop.
*   **The Senior Fix:** Adds `.includes(:user, :merchant)` to the query.
*   **Bonus:** Mentions how to detect this in logs or with tools like `Rack::MiniProfiler`.

### Task 3: New Feature (Merchant Income Report)
*   **The Target:** Implement efficiently using SQL aggregation.
*   **The Senior Fix:** `merchant.payments.where(created_at: range).sum(:amount_cents)`.
*   **Red Flag:** Fetches all records into memory and calculates the sum in Ruby.

### Probing Questions (Senior Level)
*   "What happens if `user.save!` succeeds but `Payment.create!` fails?" (Answer: Without a transaction, the user loses money without a record).
*   "How would you handle idempotency if the mobile app sends the same request twice due to a network timeout?" (Answer: Idempotency keys/tokens).
*   "How would you scale this for a 'Hot Merchant' (100+ payments/sec) where locking the merchant record becomes a bottleneck?"
