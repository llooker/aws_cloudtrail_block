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

  dimension: eventname {
    type: string
    sql: ${TABLE}.eventname ;;
  }

  dimension: eventsource {
    type: string
    sql: ${TABLE}.eventsource ;;
  }
  dimension_group: event_time {
    type: time
#     hidden: yes
    timeframes: [hour,date,week,month,year,hour_of_day,day_of_week,month_name]
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
         WHEN substr(${sourceipaddress},1,2) = '34' THEN 'London'
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

### End user fields

  dimension: vpcendpointid {
    type: string
    sql: ${TABLE}.vpcendpointid ;;
  }

  dimension: login_status {
    description: "Should only be used to evaluate logins"
    type: string
    sql: CASE
         WHEN ${eventname} = 'ConsoleLogin' AND ${errormessage} IS NULL THEN 'Success'
         WHEN ${eventname} = 'ConsoleLogin' AND ${errormessage} IS NOT NULL THEN 'Failure'
         ELSE NULL
         END
    ;;
  }

  measure: total_events {
    type: count
    drill_fields: [eventname]
  }

  measure: total_errors {
    type: count
    filters: {
      field: errormessage     ### filter on errormessage because there is always an error message during a failed login attempt
      value: "NOT NULL"
    }
  }

  measure: total_logins {
    type: count
    drill_fields: [eventname]

    filters: {
      field: eventname
      value: "ConsoleLogin"
    }
  }

  measure: total_failed_logins {
    type: count
    drill_fields: [eventname]

    filters: {
      field: eventname
      value: "ConsoleLogin"
    }
    filters: {
      field: errormessage     ### filter on errormessage because there is always an error message during a failed login attempt
      value: "NOT NULL"
    }
  }

  measure: total_successful_logins {
    type: count
    drill_fields: [eventname]

    filters: {
      field: eventname
      value: "ConsoleLogin"
    }
    filters: {
      field: errormessage    ### filter on errormessage because there is always an error message during a failed login attempt
      value: "NULL"
    }
  }

  measure: count_of_distinct_users {
    type: count_distinct
    sql: ${user_name} ;;
    value_format_name: decimal_0
    }


}
