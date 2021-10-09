variable "EDGEONE_NAME" {    
    default = "edge-one"
}

variable "AWS_REGION" {    
    default = "us-west-1"
}

variable "AWS_PROFILE" {    
    default = "default"
}

variable "instance_count" {
  default = "1"
}

variable "NGINX_TENANT_CONFIG_DIR" {    
    default = "/opt/nginx/conf/nginx-tenants.d/"
}

variable "AMI" {
    type = map
    
    default = {
        us-west-1 = "ami-011996ff98de391d1" // amazon linux 2
        eu-west-2 = "ami-03ac5a9b225e99b02" // amazon linux 2
        us-east-1 = "ami-0c2a1acae6667e438"
        ap-southeast-1 = "ami-082105f875acab993"
    }
}

variable "PUBLIC_KEY_PATH" {
type = string
default = "~/.ssh/id_rsa.pub"

}

variable "PRIVATE_KEY_PATH" {
type = string
default = "~/.ssh/id_rsa"

}

variable "EC2_USER" {
  type = string
  default = "ec2-user"
}

variable "edgeone_domain_link" {
  type = string
  default = "edgeone.cloud"
}

# variable "igw_id" {}
