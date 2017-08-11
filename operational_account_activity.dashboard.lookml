- dashboard: operational_account_activity
  title: Operational Account Activity
  layout: newspaper
  elements:
  - name: Top AWS Event Errors
    title: Top AWS Event Errors
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    type: table
    fields:
    - cloudtrail_logs.count
    - cloudtrail_logs.event_name
    - cloudtrail_logs.errorcode
    - cloudtrail_logs.errormessage
    filters:
      cloudtrail_logs.errorcode: "-NULL"
    sorts:
    - cloudtrail_logs.count desc
    limit: 15
    column_limit: 50
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      Date: cloudtrail_logs.event_time_date
    row: 4
    col: 6
    width: 18
    height: 8
  - name: Top IAM Users
    title: Top IAM Users
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    type: table
    fields:
    - cloudtrail_logs.user_name
    - cloudtrail_logs.event_name
    - cloudtrail_logs.total_events
    filters:
      cloudtrail_logs.user_type: IAMUser
    sorts:
    - cloudtrail_logs.total_events desc
    limit: 15
    column_limit: 50
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      Date: cloudtrail_logs.event_time_date
    row: 12
    col: 0
    width: 18
    height: 8
  - name: Root Activity
    title: Root Activity
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    type: table
    fields:
    - cloudtrail_logs.event_name
    - cloudtrail_logs.user_invoked_by
    - cloudtrail_logs.total_events
    filters:
      cloudtrail_logs.user_type: Root
    sorts:
    - cloudtrail_logs.total_events desc
    limit: 15
    column_limit: 50
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      Date: cloudtrail_logs.event_time_date
    row: 20
    col: 6
    width: 18
    height: 8
  - name: Top AWS Event Errors (Operations)
    type: text
    title_text: Top AWS Event Errors
    subtitle_text: ''
    body_text: "Use:  Recurring error messages can be a sign of an incorrectly configured\
      \ policy, the wrong permissions applied to an application, or an unknown change\
      \ in your workloads. The following query shows the top errors that have occurred\
      \ during the selected timeframe.\n\nInterpretation: \nThese errors might indicate\
      \ an incorrectly configured CloudWatch alarm or S3 bucket policy."
    row: 4
    col: 0
    width: 6
    height: 8
  - name: Top IAM Users (Operations)
    type: text
    title_text: Top IAM Users
    body_text: |-
      Use: This data table shows the top IAM users and activities by event name.

      Interpretation: The results will show the total activities initiated by each IAM user and the event name for those activities. Drill into this query to filter the activity and view only events that occurred outside of the known network or after hours.
    row: 12
    col: 18
    width: 6
    height: 8
  - name: Root Activity (Operations)
    type: text
    title_text: Root Activity
    body_text: |-
      Use: Another useful query is to understand how the root account and credentials are being used and which activities are being performed by root. The following query will look at the top events initiated by root from the beginning of the year.

      Interpretation: It will show whether these were direct root activities or whether they were invoked by an AWS service (and, if so, which one) to perform an activity.
    row: 20
    col: 0
    width: 6
    height: 8
  - name: Operational Account Activity
    type: text
    title_text: Operational Account Activity
    body_text: An important part of running workloads in AWS is understanding recurring
      errors, how administrators and employees are interacting with your workloads,
      and who or what is using root privileges in your account.
    row: 0
    col: 0
    width: 24
    height: 4
  filters:
  - name: Date
    title: Date
    type: date_filter
    default_value: 48 hours
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    field: cloudtrail_logs.eventtime
    listens_to_filters: []
    allow_multiple_values: true
