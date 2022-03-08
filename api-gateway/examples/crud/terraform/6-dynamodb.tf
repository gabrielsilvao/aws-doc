resource "aws_dynamodb_table" "http-crud" {
  name = "http-crud-tutorial-items"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}