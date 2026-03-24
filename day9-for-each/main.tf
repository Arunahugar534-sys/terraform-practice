variable "env" {
  description = "for-each"
  type = list(string)
  default = ["Dev","Prod"]
}

variable "ami" {
  type = string
  default = "ami-02dfbd4ff395f2a1b"
}

resource  "aws_instance" "app" {
    for_each = toset(var.env) #so here toset is used to convert list to set because for_each only accepts map and set not list
    ami = var.ami
    instance_type = "t2.micro"

    #tags = {
    #    Name = "app-${each.key}"
    #}

    tags = {

        Name = each.key
    }
}