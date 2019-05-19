# export AWS_ACCESS_KEY_ID
# export AWS_SECRET_ACCESS_KEY
variable "aws_access_key" {
             default= "aws_access_key"
             }
variable "aws_secret_key" {
               default= "aws_secret_key"
          }

variable "region" {
  type = "string"
  default =  "us-west-2"
}

# Availability Zones
variable "azs" {
  type = "list"
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "keyname" {
  default = "mediawiki"
}

variable "aws_ami" {
  default="ami-079596bf7a949ddf8"
}

variable "aws_tags" {
  type = "map"
  default = {
    "webserver1" = "MediaWiki-WebApp1"
	  "webserver2" = "MediaWiki-WebApp2"
    "dbserver" = "MediaWikiDB"
  }
}

variable "aws_instance_type" {
  default = "t2.micro"
}
