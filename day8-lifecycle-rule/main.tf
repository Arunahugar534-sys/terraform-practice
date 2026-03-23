resource "aws_s3_bucket" "name" {
    bucket = "day8-lifecycle-rule-demo2"
    lifecycle {
      prevent_destroy = true
    }
}

#create_before_destroy = true



/*resource "aws_instance" "web" {
    ami = "ami-02dfbd4ff395f2a1b"
    instance_type = "t2.micro"
    tags = {
        Name = "test"
    }

    lifecycle {
      ignore_changes = [ tags ]
    }
}
*/