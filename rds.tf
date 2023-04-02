# resource group
resource "aws_db_parameter_group" "rds-mysql-param-group" {
  name        = "rds-mysql-param-group"
  family      = "mysql8.0"
  description = "RDS MySQL parameters group"
}

# DB Subnet Group
resource "aws_db_subnet_group" "rds-mysql-subnet-group" {
  name       = "rds-mysql-subnet-group"
  subnet_ids = [aws_subnet.example.id, aws_subnet.example.id]
}

# DB instance
resource "aws_db_instance" "rds-mysql" {
  identifier             = "rds-mysql"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.23"
  instance_class         = "db.t2.micro"
  name                   = "rds_mysql_db"
  username               = "dbuser"
  password               = "dbpassword"
  db_subnet_group_name   = aws_db_subnet_group.rds-mysql-subnet-group.name
  vpc_security_group_ids = [aws_security_group.rds-mysql.id]
  parameter_group_name   = aws_db_parameter_group.rds-mysql-param-group.name
}

# security group
resource "aws_security_group" "rds-mysql" {
  name_prefix = "rds-mysql"
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr_block}"]
  }
  tags = merge(local.common_tags, { Name = "rds-mysql" })
}
