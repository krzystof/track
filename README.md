# TRACK

## Commands

- `track <project> <task>` starts a timer
- `track` show the 3 last records + the current one
- `track stop` stop the timer
- `track <project> <task>` stops the previous timer and start the new task

## Todo

- `track weekly` show the summary for the week
- add --project to scope the action (continue, switch, last)
- `track switch` switch to the previous entry with a different task
- `track continue` add a new record based on the previous record
- // todo: `track continue <#>` continue the record with the given number???
- `track last <count>` show last x records (5 by default)
- discard a record if time spent less than 5 minutes
- ask for confirmation?
- `track help` show the commands

### CI

minitest
rubocop
churn?

### Running the tests

`rake test` runs the features and unit tests
