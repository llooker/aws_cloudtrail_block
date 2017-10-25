view: cloudtrail_logs {
  sql_table_name: aws_optimizer.cloudtrail_logs ;;
  suggestions: no

  dimension: additionaleventdata {
    type: string
    sql: ${TABLE}.additionaleventdata ;;
  }

  dimension: apiversion {
    type: string
    sql: ${TABLE}.apiversion ;;
  }

  dimension: awsregion {
    type: string
    sql: ${TABLE}.awsregion ;;
  }

  dimension: errorcode {
    type: string
    sql: ${TABLE}.errorcode ;;
  }

  dimension: errormessage {
    type: string
    sql: ${TABLE}.errormessage ;;
  }

  dimension: eventid {
    type: string
    sql: ${TABLE}.eventid ;;
  }

  dimension: event_name {
    type: string
    sql: ${TABLE}.eventname ;;
  }

  dimension: event_source {
    type: string
    sql: ${TABLE}.eventsource ;;
  }
  dimension_group: event_time {
    type: time
#     hidden: yes
    timeframes: [minute15, minute30, hour,date,week,month,year,hour_of_day,day_of_week,month_name]
    sql: from_iso8601_timestamp(${TABLE}.eventtime) ;;
  }
  dimension: eventtype {
    type: string
    sql: ${TABLE}.eventtype ;;
  }

  dimension: eventversion {
    type: string
    sql: ${TABLE}.eventversion ;;
  }

  dimension: readonly {
    type: string
    sql: ${TABLE}.readonly ;;
  }

  dimension: recipientaccountid {
    type: string
    sql: ${TABLE}.recipientaccountid ;;
  }

  dimension: requestid {
    type: string
    sql: ${TABLE}.requestid ;;
  }

  dimension: requestparameters {
    type: string
    sql: ${TABLE}.requestparameters ;;
  }

  dimension: network_interface_id {
    type: string
    sql: ${TABLE}.requestparameters.networkinterfaceid ;;
  }

  dimension: resources {
    type: string
    sql: ${TABLE}.resources ;;
  }

  dimension: responseelements {
    type: string
    sql: ${TABLE}.responseelements ;;
  }

  dimension: serviceeventdetails {
    type: string
    sql: ${TABLE}.serviceeventdetails ;;
  }

  dimension: sharedeventid {
    type: string
    sql: ${TABLE}.sharedeventid ;;
  }

  dimension: mfa_used {
    description: "Multi-Factor Authentican Used"
    type: string
    sql: json_extract_scalar(${additionaleventdata}, '$.MFAUsed') ;;
  }


  dimension: sourceipaddress {
    label: "Source IP Address"
    type: string
    sql: ${TABLE}.sourceipaddress ;;
  }


### Location dimension used for demo-purposes only. To determine physical location of each IP Address, utilize a Geotargeting service, such as MaxMind
### MaxMind at https://www.maxmind.com/en/home?rId=iplocation

  dimension: ip_location {
    map_layer_name: countries
    sql: CASE
         WHEN substr(${sourceipaddress},1,2) = '54' THEN 'China'
         WHEN substr(${sourceipaddress},1,2) = '50' THEN 'Japan'
         --WHEN substr(${sourceipaddress},1,2) = '34' THEN 'London'
         WHEN substr(${sourceipaddress},1,2) = '34' THEN 'United Kingdom'
         ELSE 'United States of America'
         END
        ;;
  }




### Parsing of the nested fields (shown as JSON in useridentity column)

  dimension: user_identity {
    type: string
    group_label: "User Information"
    sql: ${TABLE}.useridentity ;;
  }

  dimension: user_agent {
    type: string
    group_label: "User Information"
    sql: ${TABLE}.useragent ;;
  }

  dimension: user_name {
    type: string
    group_label: "User Information"
    sql: ${TABLE}.useridentity.username ;;
  }

  dimension: user_type {
    type: string
    group_label: "User Information"
    sql: ${TABLE}.useridentity.type ;;
  }

  dimension: user_invoked_by {
    type: string
    group_label: "User Information"
    sql: ${TABLE}.useridentity.invokedby ;;
  }

  dimension: assumed_user_name {
    description: "Temporary security credentials obtained by assuming an IAM role"
    label: "Assumed User Name"
    type: string
    group_label: "User Information"
    sql: ${TABLE}.useridentity.sessioncontext.sessionissuer.userName ;;
  }

### End user fields

  dimension: vpcendpointid {
    type: string
    sql: ${TABLE}.vpcendpointid ;;
  }

  dimension: login_status {
    description: "Should only be used to evaluate logins"
    type: string
    sql: CASE
         WHEN ${event_name} = 'ConsoleLogin' AND ${errormessage} IS NULL THEN 'Success'
         WHEN ${event_name} = 'ConsoleLogin' AND ${errormessage} IS NOT NULL THEN 'Failure'
         ELSE NULL
         END
    ;;
  }

dimension: errors_dim {
  hidden: yes
  type: string
  sql: CASE
         WHEN ${errormessage} IS NOT NULL THEN 'Error'
         WHEN ${errormessage} IS NULL THEN 'No Error'
         ELSE NULL
         END
        ;;
}


measure: total_events {
  type: count
  drill_fields: [assumed_user_name, event_name, event_source, count]
}

measure: count {
  label: "Total Events"
  type: count
  drill_fields: [assumed_user_name, event_name, event_source, count]
}

measure: total_errors {
  type: count
  filters: {
    field: errors_dim     ### filter on errormessage because there is always an error message during a failed login attempt
    value: "Error"
  }
  drill_fields: [assumed_user_name, event_name, errorcode, errormessage, event_source, total_errors]
}

measure: total_logins {
  type: count
  drill_fields: [assumed_user_name, event_name, event_source, count]

  filters: {
    field: event_name
    value: "ConsoleLogin"
  }
}

measure: total_failed_logins {
  type: count
  drill_fields: [event_name, assumed_user_name, event_source, total_failed_logins]

  filters: {
    field: event_name
    value: "ConsoleLogin"
  }
  filters: {
    field: errors_dim     ### filter on errormessage because there is always an error message during a failed login attempt
    value: "Error"
  }
}

measure: total_successful_logins {
  type: count
  drill_fields: [event_name,total_successful_logins]

  filters: {
    field: event_name
    value: "ConsoleLogin"
  }
  filters: {
    field: errors_dim    ### filter on errormessage because there is always an error message during a failed login attempt
    value: "No Error"
  }
}


measure: count_access_denied_events {
  type: count
  drill_fields: [event_name, assumed_user_name, -user_name, user_invoked_by, count_access_denied_events]

  filters: {
    field: errorcode
    value: "AccessDenied"
  }
}

measure: count_of_distinct_call_users {
  type: count_distinct
  sql: ${user_name} ;;
  drill_fields: [user_name, user_type]
  value_format_name: decimal_0
}

measure: count_of_distinct_users {
  type: count_distinct
  drill_fields: [assumed_user_name, user_type]
  sql: ${assumed_user_name} ;;
  value_format_name: decimal_0
}

measure: errors_percent_events {
  label: "Errors As A Percent Of Events"
  sql: 1.00*${cloudtrail_logs.total_errors}/NULLIF(${cloudtrail_logs.count},0);;
  type: number
  value_format_name:percent_2}
}
