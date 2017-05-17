view: user_login_facts {
  derived_table: {
    sql: select useridentity.username,
      count(*) as number_of_console_logins,
      sum(CASE WHEN errorcode = 'AccessDenied' THEN 1 ELSE 0 END) as failed_logins,
      sum(CASE WHEN errorcode = 'AccessDenied' THEN 0 ELSE 1 END) as successful_logins,
      min(eventtime) as first_login,
      max(eventtime) as latest_login
      from aws_optimizer.cloudtrail_logs
      where eventname = 'ConsoleLogin'
      GROUP BY 1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: username {
    type: string
    primary_key: yes
    sql: ${TABLE}.username ;;
  }

  dimension: number_of_console_logins {
    type: number
    hidden: yes
    sql: ${TABLE}.number_of_console_logins ;;
  }

  dimension: failed_logins {
    type: number
    hidden: yes
    sql: ${TABLE}.failed_logins ;;
  }

  dimension: successful_logins {
    type: number
    hidden: yes
    sql: ${TABLE}.successful_logins ;;
  }

  dimension: first_login {
    type: string
    sql: ${TABLE}.first_login ;;
  }

  dimension: latest_login {
    type: string
    sql: ${TABLE}.latest_login ;;
  }

  measure: total_console_logins {
    type: sum
    sql: ${number_of_console_logins} ;;
    value_format_name: decimal_0
    drill_fields: [detail*]
  }

  measure: total_failed_logins {
    type: sum
    sql: ${failed_logins} ;;
    value_format_name: decimal_0
    drill_fields: [detail*]
  }

  measure: total_successful_logins {
    type: sum
    sql: ${successful_logins} ;;
    value_format_name: decimal_0
    drill_fields: [detail*]
  }

  set: detail {
    fields: [
      username,
      total_console_logins,
      total_failed_logins,
      total_successful_logins,
    ]
  }
}



view: user_ip_facts {
  derived_table: {
    sql: SELECT
      useridentity.username,
      count(distinct sourceipaddress) as ip_addresses
      from aws_optimizer.cloudtrail_logs
      group by 1
      order by 2 desc
      limit 50
       ;;
  }

  suggestions: no

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: username {
    type: string
    primary_key: yes
    sql: ${TABLE}.username ;;
  }

  dimension: ip_addresses {
    type: number
    sql: ${TABLE}.ip_addresses ;;
    hidden: yes
  }

  measure: number_ip_addresses {
    type: sum
    sql: ${ip_addresses} ;;
    value_format_name: decimal_0
  }

  set: detail {
    fields: [username, number_ip_addresses]
  }
}
