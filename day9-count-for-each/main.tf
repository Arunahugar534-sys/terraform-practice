variable "env" {
    description = "environments"
    type = list(string)
    default = ["Dev","Test","Prod"]
}

resource "aws_instance" "name" {
    count = length(var.env)
  ami = "ami-02dfbd4ff395f2a1b"
  instance_type = "t2.micro"
  #tags = {
    #Name = "name-${count.index}"
 # }

 tags = {

    Name = var.env[count.index]
 }

}