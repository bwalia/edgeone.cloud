// Define EC2 instance to be built
resource "aws_instance" "ca-edgeone-prod" {
    count         = var.instance_count
    ami = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type = "t3a.micro"
    iam_instance_profile = "${aws_iam_instance_profile.edgeone-ec2-profile-ap.name}"
    #instance_type = "t2.medium"
    # VPC
    subnet_id = "${aws_subnet.edgeone-subnet.id}"
    # Security Group
    vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]
    # the Public SSH key
    key_name = "${aws_key_pair.edgeone-public-key-pair-2.id}"

    # upload sources to target machine
    provisioner "file" {
        source = "src"
        destination = "/tmp/src"
    }

     # upload bash scripts to target machine
    provisioner "file" {
        source = "scripts"
        destination = "/tmp/scripts"
    }

    provisioner "file" {
        source = "templates/services-manager.service"
        destination = "/tmp/services-manager.service"
    }

    provisioner "file" {
        source = "templates/openresty.service"
        destination = "/tmp/openresty.service"
    }
    
#    provisioner "file" {
#        source = "nginx/nginx.conf"
#        destination = "/tmp/nginx.conf"
#    }

    provisioner "file" {
        source = "nginx"
        destination = "/tmp/nginx"
    }

    provisioner "file" {
        source = "templates/php-fpm-5.service"
        destination = "/tmp/php-fpm-5.service"
    }

    provisioner "file" {
        source = "php/php-fpm-5.conf"
        destination = "/tmp/php-fpm.conf"
    }

    provisioner "file" {
        source = "varnish"
        destination = "/tmp/varnish"
    }

    provisioner "file" {
        source = "templates/varnish.service"
        destination = "/tmp/varnish.service"
    }

    # Install update yum packages by executing bash script
    # services manager go app installation by executing bash script
    # Nginx/Openresty installation by executing bash script
    provisioner "remote-exec" {
        inline = [
             "chmod +x /tmp/scripts/kickstart.sh",
             "sudo /bin/bash /tmp/scripts/kickstart.sh"
        ]
    }    

    connection {
        host = self.public_ip
        user = "${var.EC2_USER}"
        private_key = "${file("${var.PRIVATE_KEY_PATH}")}"
    }

    tags = {
        Name = "${var.EDGEONE_NAME}"
    }

    provisioner "local-exec" {
        command = "echo ${self.public_dns}"
    }

    provisioner "local-exec" {
        command = "echo ${self.public_ip}"
    }
    
    provisioner "local-exec" {
        command = "echo ${self.private_ip}"
        # command = "echo ${self.public_ip} >> public_ips.txt"
        # command = "echo ${self.private_ip} >> private_ips.txt"
    }

    provisioner "local-exec" {
        command = "echo ${self.public_ip} > public_ips.txt"
    }


}

# Sends your public key to the instance
resource "aws_key_pair" "edgeone-public-key-pair-2" {
    key_name = "${var.EDGEONE_NAME}-${var.AWS_REGION}-key-pair"
    public_key = "${file(var.PUBLIC_KEY_PATH)}"
}

# output igw_id {
#   value = aws_internet_gateway.igw.id
# }


# Update Route53 with new IP of the instance
# This would create a zone which would need to be deleted and maitained using tf, uncomment it carefully
# resource "aws_route53_zone" "edgeone-glb" {
#   name     = "edgeone-glb.co.uk"
# }

# Not tested below code yet
# resource "aws_route53_record" "edgeone" {
#   zone_id = data.aws_route53_zone.edgeone-glb.zone_id
#   name    = "edgeone.${data.aws_route53_zone.edgeone-glb.name}"
#   type    = "A"
#   ttl     = "300"
#   records = [self.public_ip]
# }
