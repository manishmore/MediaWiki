
provider "aws" {
 access_key = "${var.aws_access_key}"
 secret_key = "${var.aws_secret_key}"
 region     = "${var.region}"
}

resource "tls_private_key" "mw_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "generated_key" {
  key_name   = "${var.keyname}"
  public_key = "${tls_private_key.mw_key.public_key_openssh}"
}

# Launch the instance
resource "aws_instance" "webserver1" {
  ami           = "${var.aws_ami}"
  instance_type = "${var.aws_instance_type}"
  key_name  = "${aws_key_pair.generated_key.key_name}"
  associate_public_ip_address = true
  tags {
    Name = "${lookup(var.aws_tags,"webserver1")}"
    group = "web"
  }
}

resource "aws_instance" "webserver2" {
  #depends_on = ["${aws_security_group.mw_sg}"]
  ami           = "${var.aws_ami}"
  instance_type = "${var.aws_instance_type}"
  key_name  = "${aws_key_pair.generated_key.key_name}"
  associate_public_ip_address = true
  tags {
    Name = "${lookup(var.aws_tags,"webserver2")}"
    group = "web"
  }
}



resource "aws_instance" "dbserver" {
  #depends_on = ["${aws_security_group.mw_sg}"]
  ami           = "${var.aws_ami}"
  key_name  = "${aws_key_pair.generated_key.key_name}"
  instance_type = "${var.aws_instance_type}"
  tags {
    Name = "${lookup(var.aws_tags,"dbserver")}"
    group = "db"
  }
}

output "pem" {
        value = ["${tls_private_key.mw_key.private_key_pem}"]
}
