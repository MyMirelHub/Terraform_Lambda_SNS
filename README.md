### Terraform_Lambda_SNS
This terraform script creates an AWS Lambda that will log a "Hello world" in the AWS CloudWatch logs triggered by an SNS notification. 

#### Summary
The steps to create the program were to
  1.	Create an SNS topic
  2.	Create a Lambda IAM role 
  3.	Create a Lambda Function 
  4.	Give SNS topic lambda invoke permissions 
  5.	Subscribe Lambda to SNS topic 
  6.	Create CloudWatch Log Group and attach IAM policy
  
#### Instructions: 
  1.	Unzip the folder and change to project directory in command line to access it.
  2.  Initialise terraform in the project directory running ```terraform init```
  3.	Enter access credentials in the variables configuration file: terraform.tfvars
  4.	Then to view, deploy and delete the infrastructure run: 

```console
    terraform plan -var-file terraform.tfvars 
    terraform apply -var-file terraform.tfvars
    terraform destroy -var-file terraform.tfvars
 ```
The lambda function is contained in lambda.zip. The Lambda function is: 

```Python
from __future__ import print_function
def handler(event, context):
    print('Hello World')
    return 'Hello World!'  
```

*Run in Windows10, Lambda in python 3.7 
#### Results
##### Plan
```console
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + aws_iam_role.lambda_exec_role
      id:                              <computed>
      arn:                             <computed>
      assume_role_policy:              "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\": \"sts:AssumeRole\",\n      \"Principal\": {\n        \"Service\": \"lambda.amazonaws.com\"\n      },\n      \"Effect\": \"Allow\",\n      \"Sid\": \"\"\n    }\n  ]\n}\n"
      create_date:                     <computed>
      description:                     "Allows Lambda Function to call AWS services on your behalf."
      force_detach_policies:           "false"
      max_session_duration:            "3600"
      name:                            "iam_for_lambda"
      path:                            "/"
      unique_id:                       <computed>

  + aws_iam_role_policy.lambda-cloudwatch-log-group
      id:                              <computed>
      name:                            "CloudwatchLogGropMirel"
      policy:                          "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Sid\": \"\",\n      \"Effect\": \"Allow\",\n      \"Action\": [\n
      \"logs:PutLogEvents\",\n        \"logs:CreateLogStream\",\n        \"logs:CreateLogGroup\"\n      ],\n      \"Resource\": \"arn:aws:logs:::*\"\n    }\n  ]\n}"
      role:                            "iam_for_lambda"

  + aws_lambda_function.test_lambda
      id:                              <computed>
      arn:                             <computed>
      filename:                        "lambda.zip"
      function_name:                   "Hello_Lambda"
      handler:                         "lambda.handler"
      invoke_arn:                      <computed>
      last_modified:                   <computed>
      memory_size:                     "128"
      publish:                         "false"
      qualified_arn:                   <computed>
      role:                            "${aws_iam_role.lambda_exec_role.arn}"
      runtime:                         "python3.7"
      source_code_hash:                "ICmOWXuZWOQEx9Gu3ZgVWvZNJDN2rbUyoSAzNmNhxWY="
      source_code_size:                <computed>
      timeout:                         "3"
      tracing_config.#:                <computed>
      version:                         <computed>

  + aws_lambda_permission.sns
      id:                              <computed>
      action:                          "lambda:InvokeFunction"
      function_name:                   "${aws_lambda_function.test_lambda.arn}"
      principal:                       "sns.amazonaws.com"
      source_arn:                      "${aws_sns_topic.HelloLambdaSNS.arn}"
      statement_id:                    "AllowExecutionFromSNS"

  + aws_sns_topic.HelloLambdaSNS
      id:                              <computed>
      arn:                             <computed>
      name:                            "HelloLambdaSNS"
      policy:                          <computed>

  + aws_sns_topic_subscription.example
      id:                              <computed>
      arn:                             <computed>
      confirmation_timeout_in_minutes: "1"
      endpoint:                        "${aws_lambda_function.test_lambda.arn}"
      endpoint_auto_confirms:          "false"
      protocol:                        "lambda"
      raw_message_delivery:            "false"
      topic_arn:                       "${aws_sns_topic.HelloLambdaSNS.arn}"

Plan: 6 to add, 0 to change, 0 to destroy.
```
##### Apply
```console
aws_sns_topic.HelloLambdaSNS: Creating...
  arn:    "" => "<computed>"
  name:   "" => "HelloLambdaSNS"
  policy: "" => "<computed>"
aws_iam_role.lambda_exec_role: Creating...
  arn:                   "" => "<computed>"
  assume_role_policy:    "" => "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\": \"sts:AssumeRole\",\n      \"Principal\": {\n        \"Service\": \"lambda.amazonaws.com\"\n      },\n      \"Effect\": \"Allow\",\n      \"Sid\": \"\"\n    }\n  ]\n}\n"
  create_date:           "" => "<computed>"
  description:           "" => "Allows Lambda Function to call AWS services on your behalf."
  force_detach_policies: "" => "false"
  max_session_duration:  "" => "3600"
  name:                  "" => "iam_for_lambda"
  path:                  "" => "/"
  unique_id:             "" => "<computed>"
aws_sns_topic.HelloLambdaSNS: Creation complete after 1s (ID: arn:aws:sns:eu-west-1:450280475224:HelloLambdaSNS)
aws_iam_role.lambda_exec_role: Creation complete after 1s (ID: iam_for_lambda)
aws_iam_role_policy.lambda-cloudwatch-log-group: Creating...
  name:   "" => "CloudwatchLogGropMirel"
  policy: "" => "{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Sid\": \"\",\n      \"Effect\": \"Allow\",\n      \"Action\": [\n        \"logs:PutLogEvents\",\n        \"logs:CreateLogStream\",\n        \"logs:CreateLogGroup\"\n      ],\n      \"Resource\": \"arn:aws:logs:::*\"\n    }\n  ]\n}"
  role:   "" => "iam_for_lambda"
aws_lambda_function.test_lambda: Creating...
  arn:              "" => "<computed>"
  filename:         "" => "lambda.zip"
  function_name:    "" => "Hello_Lambda"
  handler:          "" => "lambda.handler"
  invoke_arn:       "" => "<computed>"
  last_modified:    "" => "<computed>"
  memory_size:      "" => "128"
  publish:          "" => "false"
  qualified_arn:    "" => "<computed>"
  role:             "" => "arn:aws:iam::450280475224:role/iam_for_lambda"
  runtime:          "" => "python3.7"
  source_code_hash: "" => "ICmOWXuZWOQEx9Gu3ZgVWvZNJDN2rbUyoSAzNmNhxWY="
  source_code_size: "" => "<computed>"
  timeout:          "" => "3"
  tracing_config.#: "" => "<computed>"
  version:          "" => "<computed>"
aws_iam_role_policy.lambda-cloudwatch-log-group: Creation complete after 1s (ID: iam_for_lambda:CloudwatchLogGropMirel)
aws_lambda_function.test_lambda: Still creating... (10s elapsed)
aws_lambda_function.test_lambda: Creation complete after 17s (ID: Hello_Lambda)
aws_sns_topic_subscription.example: Creating...
  arn:                             "" => "<computed>"
  confirmation_timeout_in_minutes: "" => "1"
  endpoint:                        "" => "arn:aws:lambda:eu-west-1:450280475224:function:Hello_Lambda"
  endpoint_auto_confirms:          "" => "false"
  protocol:                        "" => "lambda"
  raw_message_delivery:            "" => "false"
  topic_arn:                       "" => "arn:aws:sns:eu-west-1:450280475224:HelloLambdaSNS"
aws_lambda_permission.sns: Creating...
  action:        "" => "lambda:InvokeFunction"
  function_name: "" => "arn:aws:lambda:eu-west-1:450280475224:function:Hello_Lambda"
  principal:     "" => "sns.amazonaws.com"
  source_arn:    "" => "arn:aws:sns:eu-west-1:450280475224:HelloLambdaSNS"
  statement_id:  "" => "AllowExecutionFromSNS"
aws_lambda_permission.sns: Creation complete after 1s (ID: AllowExecutionFromSNS)
aws_sns_topic_subscription.example: Creation complete after 1s (ID: arn:aws:sns:eu-west-1:450280475224:Hell...S:4faf2abc-7333-46c3-a69a-d444d9759f6a)

Apply complete! Resources: 6 added, 0 changed, 0 destroyed.
```
