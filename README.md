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
1.	Unzip the folder in the current terraform directory and change dir in command line to access it. 
2.	Enter access credentials in the variables configuration file: terraform.tfvars
3.	Then to view, deploy and delete the infrastructure run: 

```
    terraform plan -var-file terraform.tfvars
    terraform apply -var-file terraform.tfvars
    terraform destroy -var-file terraform.tfvars
 ```
The lambda function is contained in lambda.zip. The Lambda function is: 

```
from __future__ import print_function
def handler(event, context):
    print('Hello World')
    return 'Hello World!'  
```
