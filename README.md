### AWS Cloudtrail + Athena

For instructions on how to set up Cloudtrail + Athena, please follow the steps outlined in this AWS [blog post](https://aws.amazon.com/blogs/big-data/aws-cloudtrail-and-amazon-athena-dive-deep-to-analyze-security-compliance-and-operational-activity/). At Amazon's suggestion, we have included some of the information, analysis, and interpreations from this blog and repeated throughout this Block.

AWS CloudTrail and Amazon Athena help make it easier by combining the detailed CloudTrail log files with the power of the Athena SQL engine to easily find, analyze, and respond to changes and activities in an AWS account.

AWS CloudTrail records API calls and account activities and publishes the log files to Amazon S3. Account activity is tracked as an event in the CloudTrail log file. Each event carries information such as who performed the action, when the action was done, which resources were impacted, and many more details. Multiple events are stitched together and structured in a JSON format within the CloudTrail log files.

### Configuring the Hive MetaStore (easier than is sounds!)

Amazon Athena uses Apache Hive’s data definition language (DDL) to create tables and Presto, a distributed SQL engine, to run queries. Apache Hive does not natively support files in JSON, so we’ll have to use a SerDe to help Hive understand how the records should be processed. A SerDe interface is a combination of a serializer and deserializer. A deserializer helps take data and convert it into a Java object while the serializer helps convert the Java object into a usable representation.


### Sample Use-Cases

The sample use-cases below have been highlighted by the AWS team as the primary use-cases that are most applicable and valuable accross their entire customer base. Looker has also added additional use-cases based on our organization's experience using CloudTrail logs operationally.

* Console Login Overview - provides high-level overview of console login activity, including location, top users, and IP Address analysis. This dashboard can be utilized for several popular use-cases, including identifying suspicious IP logins, finding over-burdensome users, and troubleshooting login issues.

* EC2 Security Group Modifications - When reviewing an operational issue or security incident for an EC2 instance, the ability to see any associated security group change is a vital part of the analysis. The associated dashbopard can help us deep dive into security group analysis. Further detail on how to effectively use the dashboard, along with subsequent areas to explore when abnormailities or opportunities for enhancement arise, can be found on the dashboard.

*         _Cannot create because security groups are not included in our `request parameters` array_


* Operational Account Activity - An important part of running workloads in AWS is understanding recurring errors, how administrators and employees are interacting with your workloads, and who or what is using root privileges in your account.

*         _Need to make eventtime a timestamp if possible_
*         _Copy Dashboard LookML once eventtime filter has been fixed and applied to the dashboard_

### Necessary Customization
* IP Location must be updated to incorporate Geolocation services, such as those provided by MaxMind


### Athena + Looker Caveats

* Athena's architecture prohibits Looker from supporting PDTs and Symmetric Aggregates
* Athena does not support that CAST or CONCAT functions, making it impossible to declare a primary key on the base logs table
