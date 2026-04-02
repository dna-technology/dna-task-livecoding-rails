# How should I start

## Without Docker
  1. install required dependencies by running the `bundle install` command
  2. create the database using the `rake db:create` command
  3. apply migrations to the database using the `rake db:migrate` command
  4. seed the database using the `rake db:seed` command
  5. run tests by executing the `bin/rails test -v` command
  6. run the `bin/rails server` command to see whether the server starts

## Using Docker
  1. build dev image: `docker build -f Dockerfile.dev -t dna-app-dev .`
  2. run image: `docker run --name dna-app-dev -p 3000:3000 dna-app-dev`
  3. run tests: `docker exec -it dna-app-dev rails test -v`

# Scenario
Let's imagine you are working on API for backend of an online payment system.
The actors are: users (festival participants), merchants, event organiser.
We want to enable backoffice operations to the event organiser.

Currently implemented:
- Users can make a payment (with a virtual currency) to a specific merchant.
- Our system has a payment log.
- It means that information about payments are stored in a database.
- This data can be used for reporting.

# Tasks

## Task 1: Code review
Please make a code review of the currently implemented solution.

## Task 2: New endpoint
Add a new endpoint that returns the total income for a given merchant over a selected time period.

## Task 3: Bug investigation

A festival participant has filed the following support ticket:

---

> **Subject:** Cannot make a payment — "insufficient funds" error but I have credits
>
> Hi, I've been buying food and drinks all day with no issues. Now I'm trying
> to pay for one last meal (5.90 credits) and the app is telling me I don't
> have enough funds. My balance clearly shows I should have exactly enough.
> Please help!
>
> — Alice Johnson (alice@festival.com)

---

**Your task:**

1. Reproduce the issue using the rails console commands below.
2. Identify the root cause in the codebase.
3. Propose and implement a fix.

**Reproduction steps** (run in `bin/rails console` after seeding):

```ruby
alice = User.find_by(email: "alice@festival.com")
bar   = Merchant.find_by(name: "Bar")

# Alice has 50.0 credits remaining after the seed payments.
# She makes 3 purchases of 14.70 — this should leave exactly 5.90 remaining.
3.times { Payment.create_with_uuid({ amount: 14.7, user_id: alice.user_id, merchant_id: bar.merchant_id }) }

# Inspect the balance
puts alice.account.reload.balance

# Now try the payment that Alice is complaining about
Payment.create_with_uuid({ amount: 5.9, user_id: alice.user_id, merchant_id: bar.merchant_id })
```

**Expected behaviour:** the final payment succeeds — Alice has exactly 5.90 credits remaining.

**Actual behaviour:** `InsufficientFundsError` is raised.
