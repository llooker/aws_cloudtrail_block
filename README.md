### AWS Cloudtrail + Athena

For instructions on how to set up Cloudtrail + Athena, please follow the steps outlined in this AWS [blog post](https://aws.amazon.com/blogs/big-data/aws-cloudtrail-and-amazon-athena-dive-deep-to-analyze-security-compliance-and-operational-activity/). Some of the information is repeated below.

AWS CloudTrail and Amazon Athena help make it easier by combining the detailed CloudTrail log files with the power of the Athena SQL engine to easily find, analyze, and respond to changes and activities in an AWS account.

AWS CloudTrail records API calls and account activities and publishes the log files to Amazon S3. Account activity is tracked as an event in the CloudTrail log file. Each event carries information such as who performed the action, when the action was done, which resources were impacted, and many more details. Multiple events are stitched together and structured in a JSON format within the CloudTrail log files.

Amazon Athena uses Apache Hive’s data definition language (DDL) to create tables and Presto, a distributed SQL engine, to run queries. Apache Hive does not natively support files in JSON, so we’ll have to use a SerDe to help Hive understand how the records should be processed. A SerDe interface is a combination of a serializer and deserializer. A deserializer helps take data and convert it into a Java object while the serializer helps convert the Java object into a usable representation.

### Sample Use-Cases
* Console Login Overview - provides high-level overview of console login activity, including location, top users, and IP Address analysis. This dashboard can be utilized for several popular use-cases, including identifying suspicious IP logins, finding over-burdensome users, and troubleshooting login issues.

### Necessary Customization
* IP Location must be updated to incorporate Geolocation services, such as those provided by MaxMind


### Athena + Looker Caveats

* Athena's architecture prohibits Looker from supporting PDTs and Symmetric Aggregates
* Athena does not support that CAST or CONCAT functions, making it impossible to declare a primary key on the base logs table
