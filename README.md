### Set-up Steps

**Cloudtrail Config**
These instructions assume that you already have CloudTrail configured. If not, please follow the instructions outlined in these [AWS docs](http://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-getting-started.html) to complete the configuration (only takes a few min).

**Athena Config**
For instructions on how to set up Cloudtrail + Athena, please follow the steps outlined in this [AWS blog post](https://aws.amazon.com/blogs/big-data/aws-cloudtrail-and-amazon-athena-dive-deep-to-analyze-security-compliance-and-operational-activity/) (up to "Popular Use Cases"). At Amazon's suggestion, we have included some of the information, analysis, and interpreations from this blog and repeated throughout this Block.

**Performance Optimization**
Once you've completed all the initial set-up steps, you can connect Looker to your new Athena datastore and begin analysis. However, if you're working with large data sets or generally want to improve performance, there are two additional steps you should take: Partitioning your S3 buckets, and converting your data to a columnar format. Instructions for how to accomplish both of these steps are included in a seperate [AWS post](https://aws.amazon.com/blogs/big-data/analyzing-data-in-s3-using-amazon-athena/). Beyond these primary levers, there are certain best practices you can follow at query time as well, outlined in this [blog post](https://aws.amazon.com/blogs/big-data/top-10-performance-tuning-tips-for-amazon-athena/).



### AWS Cloudtrail + Athena

AWS CloudTrail and Amazon Athena help make it easier by combining the detailed CloudTrail log files with the power of the Athena SQL engine to easily find, analyze, and respond to changes and activities in an AWS account.

AWS CloudTrail records API calls and account activities and publishes the log files to Amazon S3. Account activity is tracked as an event in the CloudTrail log file. Each event carries information such as who performed the action, when the action was done, which resources were impacted, and many more details. Multiple events are stitched together and structured in a JSON format within the CloudTrail log files.

### Configuring the Hive MetaStore (easier than is sounds!)

Amazon Athena uses Apache Hive’s data definition language (DDL) to create tables and Presto, a distributed SQL engine, to run queries. The DDL statement used to create the table in this Block can be found below, or in this [AWS blog](https://aws.amazon.com/blogs/big-data/aws-cloudtrail-and-amazon-athena-dive-deep-to-analyze-security-compliance-and-operational-activity/). Apache Hive does not natively support files in JSON, so we’ll have to use a SerDe to help Hive understand how the records should be processed. A SerDe interface is a combination of a serializer and deserializer. A deserializer helps take data and convert it into a Java object while the serializer helps convert the Java object into a usable representation.

```
CREATE EXTERNAL TABLE cloudtrail_logs (
eventversion STRING,
userIdentity STRUCT<
  type:STRING,
  principalid:STRING,
  arn:STRING,
  accountid:STRING,
  invokedby:STRING,
  accesskeyid:STRING,
  userName:STRING,
  sessioncontext:STRUCT<
    attributes:STRUCT<
      mfaauthenticated:STRING,
      creationdate:STRING>,
    sessionIssuer:STRUCT<
      type:STRING,
      principalId:STRING,
      arn:STRING,
      accountId:STRING,
      userName:STRING>>>,
eventTime STRING,
eventSource STRING,
eventName STRING,
awsRegion STRING,
sourceIpAddress STRING,
userAgent STRING,
errorCode STRING,
errorMessage STRING,
requestParameters STRING,
responseElements STRING,
additionalEventData STRING,
requestId STRING,
eventId STRING,
resources ARRAY<STRUCT<
  ARN:STRING,accountId:
  STRING,type:STRING>>,
eventType STRING,
apiVersion STRING,
readOnly STRING,
recipientAccountId STRING,
serviceEventDetails STRING,
sharedEventID STRING,
vpcEndpointId STRING
)
ROW FORMAT SERDE 'com.amazon.emr.hive.serde.CloudTrailSerde'
STORED AS INPUTFORMAT 'com.amazon.emr.cloudtrail.CloudTrailInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION 's3://<Your CloudTrail s3 bucket>/AWSLogs/<optional – AWS_Account_ID>/';
```




### Sample Use-Cases

The sample use-cases below have been highlighted by the AWS team as the primary use-cases that are most applicable and valuable accross their entire customer base. Looker has also added additional use-cases based on our organization's experience using CloudTrail logs operationally.

* **General Operations** - a holistic view of event activity over time, across users, resources, and regions. Use this dashboard to illicit high-level trends, then drill down into individual resources to identify opportunities for improvement and cost savings

* **Error Overview** - identifying errors is a crucial component of maintaining an operational AWS environment. This dashboard offers an overview of the most common errors for users and AWS resources, as well as additional detail to help users rectify issues.

* **Console Login Overview** - provides high-level overview of console login activity, including location, top users, and IP Address analysis. This dashboard can be utilized for several popular use-cases, including identifying suspicious IP logins, finding over-burdensome users, and troubleshooting login issues.

* **EC2 Security Group Modifications** - when reviewing an operational issue or security incident for an EC2 instance, the ability to see any associated security group change is a vital part of the analysis. The associated dashbopard can help us deep dive into security group analysis. Further detail on how to effectively use the dashboard, along with subsequent areas to explore when abnormailities or opportunities for enhancement arise, can be found on the dashboard.

* **Operational Account Activity** - a key component of running workloads in AWS is understanding recurring errors, how administrators and employees are interacting with your workloads, and who or what is using root privileges in your account.



### Necessary Customization
* IP Location must be updated to incorporate Geolocation services, such as those provided by MaxMind
