connection: "aws_optimizer"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: cloudtrail_logs {}

# - explore: cloudfront_logs

# - explore: elasticbeanstalk_logs
