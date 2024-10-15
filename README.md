# How should I start
1. install required dependencies by running the `bundle install` command
2. create the database using the `rake db:create` command
3. apply migrations to the database using the `rake db:migrate` command
3. run tests by executing the `bin/rails test -v` command
5. run the `bin/rails server` command to see whether the server starts

## Scenario
Let’s imagine you are working on API for backend of an online payment system.
The actors are: users (festival participants), merchants, event organiser.
We want to enable backoffice operations to the event organiser.

Currently implemented:
- Users can make a payment (with a virtual currency) to a specific merchant.
- Our system has a payment log.
- It means that information about payments are stored in a database.
- This data can be used for reporting.

# Tasks
## Task 1:
Please make a code review of the currently implemented solution.
## Task 2:
Add new endpoint which give total income for payments for selected time period for given merchant.