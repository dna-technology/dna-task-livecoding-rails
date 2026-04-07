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
