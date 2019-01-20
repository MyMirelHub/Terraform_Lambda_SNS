# Your aws credentials - input in terraform.tvvars 
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}
#SNS topic which will trigger lambda
resource "aws_sns_topic" "HelloLambdaSNS" {
  name = "HelloLambdaSNS"
}
#Create Lambda iam role, and assign json policy
resource "aws_iam_role" "lambda_exec_role" {
  name = "iam_for_lambda"
  description = "Allows Lambda Function to call AWS services on your behalf."
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
#Create Lambda Function 
resource "aws_lambda_function" "test_lambda" {
  filename         = "${var.filename}"
  function_name    = "${var.function_name}"
  role             = "${aws_iam_role.lambda_exec_role.arn}"
  handler          = "${var.handler}"
  source_code_hash = "${base64sha256(file("${var.filename}"))}"
  runtime          = "${var.runtime}"
  depends_on       =["aws_sns_topic.HelloLambdaSNS"]
}
#SNS permissions to invoke lambda function 
resource "aws_lambda_permission" "sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.test_lambda.arn}"
  principal     = "sns.amazonaws.com"
  source_arn = "${aws_sns_topic.HelloLambdaSNS.arn}"
}

#subscribe Lambda function to SNS topic
resource "aws_sns_topic_subscription" "example" {
  depends_on = ["aws_lambda_function.test_lambda"]
  topic_arn = "${aws_sns_topic.HelloLambdaSNS.arn}"
  protocol = "lambda"
  endpoint = "${aws_lambda_function.test_lambda.arn}"
}

#Create cloudwatch log group 
resource "aws_iam_role_policy" "lambda-cloudwatch-log-group" {
  name = "CloudwatchLogGropMirel"
  role = "${aws_iam_role.lambda_exec_role.name}"
  policy = "${data.aws_iam_policy_document.cloudwatch-log-group-lambda.json}"
}
 #JSON Policy for cloudwatch logs 
data "aws_iam_policy_document" "cloudwatch-log-group-lambda" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
 
    resources = [
      "arn:aws:logs:::*",
    ]
  }
}