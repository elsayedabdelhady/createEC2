provider "aws" {
  access_key = ""
  secret_key = ""
  region = "us-east-1"
  default_tags {
   tags = {
     Name= "EC2formTerrafrom" 
     Environment = "elsayed"
     Owner       = "TFProviders"
     Project     = "Test"
   }
  }
 
}
variable "prefix" {
  description = "servername prefix"
  default = "gritfyapp"
}
resource "aws_instance" "web" {
  ami           = "ami-0232702e0434e2418"
  instance_type = "t2.micro"
  count = 1
  key_name      = aws_key_pair.kp.key_name
   volume_tags = {
     Name= "EC2formTerrafrom" 
     Environment = "elsayed"
     Owner       = "elsayed"
     Project     = "Test"
     }
     user_data = <<-EOL
      #!/bin/bash -xe
      sudo yum install epel-release  
      sudo yum update -y
      sudo install python-pip -y
      sudo yum install nginx     
      EOL
}
output "instances" {
  value       = "${aws_instance.web.*.public_ip}"
  description = "PublicIP address details"
}
