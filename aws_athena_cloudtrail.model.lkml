connection: "aws_optimizer"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: cloudtrail_logs {
  join: user_login_facts {
    type: left_outer
    sql_on: ${cloudtrail_logs.user_name} = ${user_login_facts.username} ;;
    relationship: many_to_one
  }
  join: user_ip_facts {
    type: left_outer
    sql_on: ${cloudtrail_logs.user_name} = ${user_ip_facts.username} ;;
    relationship: many_to_one
  }
}

explore: user_login_facts {}

explore: user_ip_facts {}
