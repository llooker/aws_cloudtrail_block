- dashboard: ec2_security_group_modifications
  title: EC2 Security Group Modifications
  layout: newspaper
  elements:
  - name: Security Group Modifications
    title: Security Group Modifications
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    type: table
    fields:
    - cloudtrail_logs.event_name
    - cloudtrail_logs.user_name
    - cloudtrail_logs.sourceipaddress
    # - cloudtrail_logs.event_time
    - cloudtrail_logs.requestparameters
    sorts:
    - cloudtrail_logs.eventname
    limit: 500
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
      Security Group: cloudtrail_logs.requestparameters
      Network ID: cloudtrail_logs.requestparameters
      Date: cloudtrail_logs.event_time_date
    row: 8
    col: 0
    width: 24
    height: 8
  - name: How do I identify Security Modifications?
    type: text
    title_text: How do I identify Security Modifications?
    body_text: |-
      If an EC2 instance triggers a CloudWatch metric alarm for high CPU utilization, we can first look to see if there have been any security group changes (the addition of new security groups or the addition of ingress rules to an existing security group) that potentially create more traffic or load on the instance. To start the investigation, we need to look in the EC2 console for the network interface ID and security groups of the impacted EC2 instance.

      The following query can help us dive deep into the security group analysis.
    row: 0
    col: 0
    width: 12
    height: 8
  - name: What does the below query tell me?
    type: text
    title_text: What does the below query tell me?
    body_text: "We’ll configure the query to filter for our network interface ID,\
      \ security groups, and a time range starting X hours before the alarm occurred\
      \ so we’re aware of recent changes. \n\nSet your security group filter to the\
      \ group that exhibited abnormal activity.\n\nSet your Network Interface ID filter\
      \ to the network ID of the impacted EC2 instance."
    row: 0
    col: 12
    width: 12
    height: 8
  filters:
  - name: Security Group
    title: Security Group
    type: field_filter
    default_value: "%sg%"
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    field: cloudtrail_logs.requestparameters
    listens_to_filters: []
    allow_multiple_values: true
  - name: Network ID
    title: Network ID
    type: field_filter
    default_value: "%eni-%"
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    field: cloudtrail_logs.requestparameters
    listens_to_filters: []
    allow_multiple_values: true
  - name: Date
    title: Date
    type: date_filter
    default_value: 1 years
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    field: cloudtrail_logs.event_date
    listens_to_filters: []
    allow_multiple_values: true
