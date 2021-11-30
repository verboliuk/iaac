resource "aws_db_instance" "epam-rds" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "epam"
  skip_final_snapshot  = true
  publicly_accessible  = true
  username             = "epam"
  password             = "epam123"
  parameter_group_name = "default.mysql5.7"

  tags = {
    "Name" = "epam-rds"
  }
}
