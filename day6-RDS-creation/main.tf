resource "aws_db_instance" "default" {
    allocated_storage = 80
    db_name = "mydb"
    identifier = "rds-test"
    engine = "mysql"
    instance_class = "db.t3.micro"
    username = "admin"
    password = "12345678"
    parameter_group_name = "default.mysql8.4"
    backup_retention_period = 7
    backup_window = "02:00-03:00"
    maintenance_window = "sun:04:00-sun:05:00"
    deletion_protection = true
    skip_final_snapshot = true

}