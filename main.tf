provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "jenkins" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI (example)
  instance_type = "t2.micro"
  key_name      = "technova-key" # Your key

  tags = {
    Name = "jenkins-server"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install docker -y",
      "sudo service docker start",
      "sudo usermod -aG docker ec2-user"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/technova.pem")
      host        = self.public_ip
    }
  }
}
