- dashboard: error_overivew
  title: Error Overivew
  layout: newspaper
  elements:
  - name: Top Assumed User Types
    title: Top Assumed User Types
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    type: looker_column
    fields:
    - cloudtrail_logs.total_errors
    - cloudtrail_logs.assumed_user_name
    filters:
    sorts:
    - cloudtrail_logs.total_errors desc
    limit: 10
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
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
    series_colors:
      cloudtrail_logs.total_errors: "#1f3e5a"
    x_axis_label_rotation: -30
    colors:
    - 'palette: Looker Classic'
    series_types:
      errors_as_a_percent_of_events: line
    hidden_series: []
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: errors_as_a_percent_of_events
        name: Errors as a Percent of Events
        __FILE: aws_athena_cloudtrail/error_overview.dashboard.lookml
        __LINE_NUM: 180
      __FILE: aws_athena_cloudtrail/error_overview.dashboard.lookml
      __LINE_NUM: 168
    - label:
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: total_errors
        name: Total Errors
        __FILE: aws_athena_cloudtrail/error_overview.dashboard.lookml
        __LINE_NUM: 194
      __FILE: aws_athena_cloudtrail/error_overview.dashboard.lookml
      __LINE_NUM: 182
    listen:
      Date: cloudtrail_logs.event_time_date
    row: 8
    col: 15
    width: 9
    height: 7
  - name: Errors by User Type
    title: Errors by User Type
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    type: looker_pie
    fields:
    - cloudtrail_logs.total_errors
    - cloudtrail_logs.user_type
    filters:
    sorts:
    - cloudtrail_logs.total_errors desc
    limit: 10
    column_limit: 50
    value_labels: legend
    label_type: labPer
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
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    series_colors:
      cloudtrail_logs.total_errors: "#1f3e5a"
      AssumedRole: "#1f3e5a"
    x_axis_label_rotation: -30
    inner_radius: 45
    listen:
      Date: cloudtrail_logs.event_time_date
    row: 8
    col: 0
    width: 9
    height: 7
  - name: Errors by Source
    title: Errors by Source
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    type: table
    fields:
    - cloudtrail_logs.total_errors
    - cloudtrail_logs.event_source
    filters:
      cloudtrail_logs.total_errors: ">0"
    sorts:
    - cloudtrail_logs.total_errors desc
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
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    series_types: {}
    listen:
      Date: cloudtrail_logs.event_time_date
    row: 8
    col: 9
    width: 6
    height: 7
  - name: Errors and Events Over Time
    title: Errors and Events Over Time
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    type: looker_column
    fields:
    - cloudtrail_logs.errors_percent_events
    - cloudtrail_logs.total_errors
    - cloudtrail_logs.count
    - cloudtrail_logs.event_time_minute30
    fill_fields:
    - cloudtrail_logs.event_time_minute30
    sorts:
    - cloudtrail_logs.event_time_minute30
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
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
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_null_points: true
    point_style: none
    interpolation: linear
    series_types:
      errors_as_a_percent_of_events: line
      cloudtrail_logs.errors_percent_events: line
    series_colors:
      errors_as_a_percent_of_events: "#a9c574"
      total_errors: "#1f3e5a"
      cloudtrail_logs.total_errors: "#1f3e5a"
      cloudtrail_logs.errors_percent_events: "#a9c574"
      cloudtrail_logs.count: "#1f3e5a"
    hidden_fields:
    - cloudtrail_logs.total_errors
    y_axes:
    - label:
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom:
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: cloudtrail_logs.errors_percent_events
        name: Errors As A Percent Of Events
        __FILE: aws_athena_cloudtrail/error_overview.dashboard.lookml
        __LINE_NUM: 280
      __FILE: aws_athena_cloudtrail/error_overview.dashboard.lookml
      __LINE_NUM: 268
    - label:
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom:
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: cloudtrail_logs.count
        name: Total Events
        __FILE: aws_athena_cloudtrail/error_overview.dashboard.lookml
        __LINE_NUM: 294
      __FILE: aws_athena_cloudtrail/error_overview.dashboard.lookml
      __LINE_NUM: 282
    hidden_series: []
    colors:
    - 'palette: Looker Classic'
    listen:
      Date: cloudtrail_logs.event_time_date
    row: 0
    col: 0
    width: 24
    height: 8
  - name: Top Events with Errors
    title: Top Events with Errors
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    type: looker_bar
    fields:
    - cloudtrail_logs.count
    - cloudtrail_logs.event_name
    filters:
      cloudtrail_logs.errorcode: "-NULL"
      cloudtrail_logs.errormessage: "-NULL"
    sorts:
    - cloudtrail_logs.count desc
    limit: 10
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
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
    label: Top AWS Event Errors
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    series_colors:
      cloudtrail_logs.count: "#1f3e5a"
    x_axis_label_rotation: -45
    listen:
      Date: cloudtrail_logs.event_time_date
    row: 15
    col: 0
    width: 12
    height: 10
  - name: Top Error Codes
    title: Top Error Codes
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    type: looker_bar
    fields:
    - cloudtrail_logs.count
    - cloudtrail_logs.errorcode
    filters:
      cloudtrail_logs.errorcode: "-NULL"
      cloudtrail_logs.errormessage: "-NULL"
    sorts:
    - cloudtrail_logs.count desc
    limit: 10
    column_limit: 50
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
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
    label: Top AWS Event Errors
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    enable_conditional_formatting: false
    conditional_formatting_ignored_fields: []
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    series_colors:
      cloudtrail_logs.count: "#1f3e5a"
    x_axis_label_rotation: -45
    listen:
      Date: cloudtrail_logs.event_time_date
    row: 15
    col: 12
    width: 12
    height: 10
  - name: Assumed IAM User Errors (Full Detail)
    title: Assumed IAM User Errors (Full Detail)
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    type: table
    fields:
    - cloudtrail_logs.assumed_user_name
    - cloudtrail_logs.event_name
    - cloudtrail_logs.errorcode
    - cloudtrail_logs.errormessage
    - cloudtrail_logs.count
    - cloudtrail_logs.event_source
    filters:
      cloudtrail_logs.errorcode: "-NULL"
      cloudtrail_logs.count: ">1"
    sorts:
    - cloudtrail_logs.count desc
    limit: 500
    column_limit: 50
    label: Top AWS Event Errors
    show_view_names: false
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
    row: 25
    col: 0
    width: 24
    height: 8
  filters:
  - name: Date
    title: Date
    type: date_filter
    default_value: 48 hours
    model:
    explore:
    field:
    listens_to_filters: []
    allow_multiple_values: true
