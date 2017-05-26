# TRACK

## Commands

- `track` show the 3 last completed records + the current one
- `track <project> <task>` starts a timer. task is optional. if a task is running, it will prompt for confirmation to close the current record
- `track continue` add a new record based on the previous record
- `track stop` stop the timer
- `track last <count>` show last x records (5 by default)
- `track week` show the summary + totals for the week
- `track weeks <count>` show the totals for the last weeks
- `track sum` show the sum per project of all time

Flags
- `-w` or `--weekly`
- `-m` or `--monthly`
- `-p` or `--project`

## Todo

- `track sum --monthly` show the sum of all time per month
- `track sum --weekly` show the sum of all time per week
- `track sum --project <project>` show the sum of a project
- trk week when its empty
- order by start desc when getting last orders
- `track <cmd> -p <project>` or `--<project>` filter `last`, `week` command on the given project
- `track today` show the summary + totals for today
- `track days <count>` show the totals for the last count days
- `track switch` switch to the previous entry with a different task
- `track help` show the commands
- when there is no task, write "Finish working on project" directly
- if working on no specific task, don't print it in the output (eg "working on task '-' = is ugly")

#### To think about
- ask for confirmation?
- // todo: `track continue <#>` continue the record with the given number???

## Refactor!
- use different drivers in timelog (json, sqlite, ...)
- todo: test cumulative report

### CI

minitest
rubocop
churn?

### Run the tests
`rake test` to run the minitest suite
