resource "aws_iam_role" "edgeone-ec2-role" {
  name = "edgeone-ec2-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      name = "edgeone-ec2-role"
  }
}


resource "aws_iam_instance_profile" "edgeone-ec2-profile" {
  name = "edgeone-ec2-profile"
  role = "${aws_iam_role.edgeone-ec2-role.name}"
}


resource "aws_iam_role_policy" "edgeone-ec2-role-policy" {
  name = "edgeone-ec2-role-policy"
  role = "${aws_iam_role.edgeone-ec2-role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
