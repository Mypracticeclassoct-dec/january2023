resource "aws_vpc" "vpcmain"{
    cidr_block = "10.0.0.0/8"
    tags={
        Name = "Taskjan31"
    }
}