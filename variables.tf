/*
This file is typically called variables.tf by convention. 
It’s typically full of environment specific configuration.
*/

variable "aws_access_key" {}
variable "aws_secret_key" {}

#Specify Region to access 
variable "aws_region" {
    description = "Default Region"
    default = "eu-west-1"
}

#--------------------------
#Lambda Configuration 
#--------------------------

#The filename of the lambda code to execute in your project dir
variable "filename" {
  default = "lambda.zip"
}

#Code execution runtime
variable "runtime" {
  default = "python3.7"
}

#Lambda fuction name
variable "function_name" {
  default = "Hello_Lambda"
}

#Lambda function in the code which lambda invokes to execute 
variable "handler" {
  default = "lambda.handler"
}