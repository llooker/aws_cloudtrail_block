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

  dimension: eventtime {
    type: string
    sql: ${TABLE}.eventtime ;;
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

  dimension: sourceipaddress {
    type: string
    sql: ${TABLE}.sourceipaddress ;;
  }

  dimension: useragent {
    type: string
    sql: ${TABLE}.useragent ;;
  }

  dimension: useridentity {
    type: string
    sql: ${TABLE}.useridentity ;;
  }

  dimension: vpcendpointid {
    type: string
    sql: ${TABLE}.vpcendpointid ;;
  }

  measure: count {
    type: count
    drill_fields: [eventname]
  }
}
