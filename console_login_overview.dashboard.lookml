- dashboard: console_login_overview
  title: Console Login Overview
  layout: newspaper
  elements:
  - name: Top User Logins (Top 10)
    title: Top User Logins (Top 10)
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    type: looker_bar
    fields:
    - cloudtrail_logs.total_successful_logins
    - cloudtrail_logs.total_failed_logins
    - cloudtrail_logs.total_logins
    - cloudtrail_logs.user_name
    sorts:
    - cloudtrail_logs.total_logins desc
    limit: 10
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    - cloudtrail_logs.total_logins
    colors:
    - 'palette: Looker Classic'
    series_colors:
      cloudtrail_logs.total_successful_logins: "#1f3e5a"
    series_types:
      success_rate: line
    listen:
      Date: cloudtrail_logs.event_time_date
    row: 0
    col: 12
    width: 12
    height: 10
  - name: Console Logins Over Time
    title: Console Logins Over Time
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    type: looker_column
    fields:
    - cloudtrail_logs.total_successful_logins
    - cloudtrail_logs.total_failed_logins
    - cloudtrail_logs.total_logins
    - cloudtrail_logs.event_time_date
    fill_fields:
    - cloudtrail_logs.event_time_date
    sorts:
    - cloudtrail_logs.event_time_date
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    hidden_fields:
    - cloudtrail_logs.total_logins
    series_colors:
      cloudtrail_logs.total_successful_logins: "#1f3e5a"
    listen:
      Date: cloudtrail_logs.event_time_date
    row: 10
    col: 0
    width: 12
    height: 7
  - name: Logins from Multiple IP Addresses
    title: Logins from Multiple IP Addresses
    model: aws_athena_cloudtrail
    explore: user_ip_facts
    type: table
    fields:
    - user_ip_facts.username
    - user_ip_facts.number_ip_addresses
    sorts:
    - user_ip_facts.number_ip_addresses desc
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
    row: 17
    col: 0
    width: 6
    height: 7
  - name: Most Common IP Addresses
    title: Most Common IP Addresses
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    type: table
    fields:
    - cloudtrail_logs.sourceipaddress
    - cloudtrail_logs.total_events
    sorts:
    - cloudtrail_logs.count desc
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
      Date: cloudtrail_logs.event_time_date
    row: 17
    col: 6
    width: 6
    height: 7
  - name: User Login Geolocation
    title: User Login Geolocation
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    type: looker_map
    fields: [cloudtrail_logs.ip_location, cloudtrail_logs.total_events]
    filters:
      cloudtrail_logs.ip_location: "-NULL"
      cloudtrail_logs.event_time_date: 1 years
    sorts: [cloudtrail_logs.ip_location]
    limit: 500
    column_limit: 50
    map: auto
    map_projection: ''
    show_view_names: true
    quantize_colors: false
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    map_latitude: 32.02670629333614
    map_longitude: 4.833984375000001
    map_zoom: 3
    series_types: {}
    heatmap_gridlines_empty: false
    reverse_map_value_colors: false
    row: 0
    col: 0
    width: 12
    height: 10

    # model: aws_athena_cloudtrail
    # explore: cloudtrail_logs
    # type: looker_geo_choropleth
    # fields:
    # - cloudtrail_logs.ip_location
    # - cloudtrail_logs.total_events
    # filters:
    #   cloudtrail_logs.ip_location: "-NULL"
    # sorts:
    # - cloudtrail_logs.ip_location
    # limit: 500
    # column_limit: 50
    # map: auto
    # map_projection: ''
    # show_view_names: true
    # quantize_colors: false
    # map_plot_mode: points
    # heatmap_gridlines: false
    # heatmap_opacity: 0.5
    # show_region_field: true
    # draw_map_labels_above_data: true
    # map_tile_provider: positron
    # map_position: custom
    # map_scale_indicator: 'off'
    # map_pannable: true
    # map_zoomable: true
    # map_marker_type: circle
    # map_marker_icon_name: default
    # map_marker_radius_mode: proportional_value
    # map_marker_units: meters
    # map_marker_proportional_scale_type: linear
    # map_marker_color_mode: fixed
    # show_legend: true
    # quantize_map_value_colors: false
    # map_latitude: 32.02670629333614
    # map_longitude: 4.833984375000001
    # map_zoom: 3
    # series_types: {}
    # listen:
    #   Date: cloudtrail_logs.event_time_date
    row: 0
    col: 0
    width: 12
    height: 10
  - name: Most Common Login Errors
    title: Most Common Login Errors
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    type: table
    fields:
    - cloudtrail_logs.errormessage
    - cloudtrail_logs.count
    - cloudtrail_logs.count_of_distinct_users
    filters:
      cloudtrail_logs.errorcode: "-NULL"
      cloudtrail_logs.event_name: ConsoleLogin
    sorts:
    - cloudtrail_logs.count desc
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: count_of_error_messages
      label: Count of Error Messages
      expression: "${cloudtrail_logs.count}"
      value_format:
      value_format_name: decimal_0
    - table_calculation: users_impacted_by_error
      label: Users Impacted by Error
      expression: "${cloudtrail_logs.count_of_users}"
      value_format:
      value_format_name: decimal_0
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
    hidden_fields:
    - cloudtrail_logs.count
    - cloudtrail_logs.count_of_users
    listen:
      Date: cloudtrail_logs.event_time_date
    row: 17
    col: 18
    width: 6
    height: 7
  - name: Login User Count Over Time
    title: Login User Count Over Time
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    type: looker_column
    fields:
    - cloudtrail_logs.count_of_distinct_users
    - cloudtrail_logs.event_time_date
    fill_fields:
    - cloudtrail_logs.event_time_date
    sorts:
    - cloudtrail_logs.event_time_date desc
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
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_colors:
      cloudtrail_logs.count_of_users: "#1f3e5a"
      cloudtrail_logs.count_of_distinct_users: "#1f3e5a"
    listen:
      Date: cloudtrail_logs.event_time_date
    row: 10
    col: 12
    width: 12
    height: 7
  - name: Logins without Multi-Factor Auth
    title: Logins without Multi-Factor Auth
    model: aws_athena_cloudtrail
    explore: cloudtrail_logs
    type: table
    fields:
    - cloudtrail_logs.user_name
    - cloudtrail_logs.login_status
    - cloudtrail_logs.total_logins
    filters:
      cloudtrail_logs.mfa_used: 'No'
    sorts:
    - cloudtrail_logs.total_logins desc
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
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
    row: 17
    col: 12
    width: 6
    height: 7
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
