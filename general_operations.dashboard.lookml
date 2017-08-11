- dashboard: general_operations
  title: General Operations
  layout: newspaper
  elements:
  - name: Top 10 Events
    title: Top 10 Events
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    type: looker_bar
    fields:
    - cloudtrail_logs.total_events
    - cloudtrail_logs.event_name
    sorts:
    - cloudtrail_logs.total_events desc
    limit: 10
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    value_labels: legend
    label_type: labPer
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    series_colors:
      cloudtrail_logs.total_events: "#1f3e5a"
    listen:
      Date: cloudtrail_logs.event_time_date
    row: 0
    col: 0
    width: 12
    height: 8
  - name: Top Events (Full Detail)
    title: Top Events (Full Detail)
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    type: table
    fields:
    - cloudtrail_logs.total_events
    - cloudtrail_logs.event_name
    - cloudtrail_logs.count_of_distinct_users
    - cloudtrail_logs.count_access_denied_events
    - cloudtrail_logs.errors_percent_events
    sorts:
    - cloudtrail_logs.total_events desc
    limit: 100
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
    value_labels: legend
    label_type: labPer
    series_types: {}
    listen:
      Date: cloudtrail_logs.event_time_date
    row: 0
    col: 12
    width: 12
    height: 8
  - name: Events by Source
    title: Events by Source
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    type: looker_column
    fields:
    - cloudtrail_logs.total_events
    - cloudtrail_logs.event_source
    sorts:
    - cloudtrail_logs.event_source
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: false
    point_style: none
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    series_colors:
      cloudtrail_logs.total_events: "#1f3e5a"
    listen:
      Date: cloudtrail_logs.event_time_date
    row: 8
    col: 0
    width: 12
    height: 8
  - name: Events by Region
    title: Events by Region
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    type: looker_area
    fields:
    - cloudtrail_logs.total_events
    - cloudtrail_logs.awsregion
    - cloudtrail_logs.event_time_date
    pivots:
    - cloudtrail_logs.awsregion
    fill_fields:
    - cloudtrail_logs.event_time_date
    sorts:
    - cloudtrail_logs.awsregion
    - cloudtrail_logs.event_time_date desc
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen:
      Date: cloudtrail_logs.event_time_date
    row: 16
    col: 0
    width: 12
    height: 8
  - name: Events by Hour of Day, Day of Week
    title: Events by Hour of Day, Day of Week
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    type: looker_line
    fields:
    - cloudtrail_logs.event_time_hour_of_day
    - cloudtrail_logs.event_time_day_of_week
    - cloudtrail_logs.total_events
    pivots:
    - cloudtrail_logs.event_time_day_of_week
    fill_fields:
    - cloudtrail_logs.event_time_hour_of_day
    - cloudtrail_logs.event_time_day_of_week
    filters:
      cloudtrail_logs.awsregion: ''
    sorts:
    - cloudtrail_logs.event_time_day_of_week 0
    - cloudtrail_logs.event_time_hour_of_day
    limit: 500
    column_limit: 50
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    row: 8
    col: 12
    width: 12
    height: 8
  - name: EC2 Instance Changes
    title: EC2 Instance Changes
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    type: looker_line
    fields:
    - cloudtrail_logs.total_events
    - cloudtrail_logs.event_time_date
    - cloudtrail_logs.event_name
    pivots:
    - cloudtrail_logs.event_name
    fill_fields:
    - cloudtrail_logs.event_time_date
    filters:
      cloudtrail_logs.event_name: "%StopInstance%,%StartInstance%,%RunInstance%,%TerminateInstance%"
    sorts:
    - cloudtrail_logs.event_time_date desc
    - cloudtrail_logs.event_name
    limit: 500
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    row: 16
    col: 12
    width: 12
    height: 8
  filters:
  - name: Date
    title: Date
    type: date_filter
    default_value: 1 years
    model:
    explore:
    field:
    listens_to_filters: []
    allow_multiple_values: true
