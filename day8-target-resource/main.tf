resource "aws_instance" "web" {
    ami="ami-02dfbd4ff395f2a1b"
    instance_type = "t2.micro" 
    tags = {
        Name = "Devops"
    }
}

resource "aws_s3_bucket" "name" {
    bucket = "day8-target-resource"
}