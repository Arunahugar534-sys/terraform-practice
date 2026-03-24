resource "aws_security_group" "sg-rule" {
    name = "public-sg"
    description = "Allow multiplee destinations"

   # ingress  {
    #    description = "Allow SSH port"
     #   from_port = 22
      #  to_port = 22
      #  protocol = "tcp"
       # cidr_blocks = ["0.0.0.0/0"]
    #}

   # ingress {
    #    description = "Allow http port"
     #   from_port = 80
      #  to_port = 80
       # protocol = "tcp"
        #cidr_blocks = ["0.0.0.0/0"]

    #}

    #ingress {
     #   description = "Allow https port"
      #  from_port = 443
       # to_port = 443
        #cidr_blocks = ["0.0.0.0/0"]
    #}

    #egress  {
     #   from_port = 0
      #  to_port = 0
       # protocol = "-1"
        #cidr_blocks = ["0.0.0.0/0"]
    #}

    ingress = [
        for port in [22,80,443] : {
            description =  "Allow multiple ports"
            from_port = port
            to_port = port
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
            ipv6_cidr_blocks = []
            security_groups = []
            prefix_list_ids = []
            self = false
        }
    ]

    egress {
        from_port = 0
        to_port = 0
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "public-sg-rule2"
    }

    }



