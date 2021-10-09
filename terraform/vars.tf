variable "EDGEONE_NAME" {    
    default = "edge-one"
}

variable "AWS_REGION" {    
    default = "eu-west-2"
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
        eu-west-2 = "ami-03ac5a9b225e99b02" // amazon linux 2
        us-east-1 = "ami-0c2a1acae6667e438"
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
