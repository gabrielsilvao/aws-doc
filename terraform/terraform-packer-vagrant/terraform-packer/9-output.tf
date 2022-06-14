output "db-endpoint" {
    value = aws_db_instance.wordpress.endpoint
}

output "wordpress_ip" {
  value = aws_instance.wordpress.public_ip
}