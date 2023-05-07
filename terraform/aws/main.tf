/* 
This Terraform script creates 3 VMs in the same VPC network.
The 1st VM has 3 NICs and the 2nd and 3rd VMs have 2 NICs.

You can use this script to create a test environment for T-Rex.
NOTE: Edit the script to add your values before deployment.
*/
provider "aws" {
  region = "us-west-2"
}

# Create 1st VM with N2 machine type, 32GB RAM, Intel Cascade Lake CPU type, and 3 NICs
resource "aws_instance" "vm1" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "n2.xlarge"
  subnet_id     = "<default_subnet_id>"

  vpc_security_group_ids = [
    "<security_group_id>"
  ]

  network_interface {
    network_interface_id = "${aws_network_interface.vm1-nic.id}"
    device_index         = 0
  }
  network_interface {
    network_interface_id = "${aws_network_interface.vm1-nic2.id}"
    device_index         = 1
  }
  network_interface {
    network_interface_id = "${aws_network_interface.vm1-nic3.id}"
    device_index         = 2
  }

  tags = {
    Name = "vm1"
  }
}

resource "aws_network_interface" "vm1-nic" {
  subnet_id = "<default_subnet_id>"
}

resource "aws_network_interface" "vm1-nic2" {
  subnet_id = "<t-rex-1_subnet_id>"
}

resource "aws_network_interface" "vm1-nic3" {
  subnet_id = "<t-rex-2_subnet_id>"
}

# Create 2nd and 3rd VMs with Debian 11 OS and 2 NICs
resource "aws_instance" "vm2" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = "<default_subnet_id>"

  vpc_security_group_ids = [
    "<security_group_id>"
  ]

  network_interface {
    network_interface_id = "${aws_network_interface.vm2-nic.id}"
    device_index         = 0
  }
  network_interface {
    network_interface_id = "${aws_network_interface.vm2-nic2.id}"
    device_index         = 1
  }

  tags = {
    Name = "vm2"
  }
}

resource "aws_network_interface" "vm2-nic" {
  subnet_id = "<default_subnet_id>"
}

resource "aws_network_interface" "vm2-nic2" {
  subnet_id = "<t-rex-1_subnet_id>"
}

resource "aws_instance" "vm3" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  subnet_id     = "<default_subnet_id>"

  vpc_security_group_ids = [
    "<security_group_id>"
  ]

  network_interface {
    network_interface_id = "${aws_network_interface.vm3-nic.id}"
    device_index         = 0
  }
  network_interface {
    network_interface_id = "${aws_network_interface.vm3-nic2.id}"
    device_index         = 1
  }

  tags = {
    Name = "vm3"
  }
}

resource "aws_network_interface" "vm3-nic" {
  subnet_id = "<default_subnet_id>"
}

resource "aws_network_interface" "vm3-nic2" {
  subnet_id = "<t-rex-1_subnet_id>"
}
