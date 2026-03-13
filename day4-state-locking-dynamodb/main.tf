resource "aws_db_instance" "name" {
    allocated_storage = 20
    engine = "mysql"
    instance_class = "db.t2.micro"
    username = admin
    password = "12345678"
    skip_final_snapshot = true
}