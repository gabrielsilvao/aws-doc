resource "aws_lambda_function" "name" {
  filename = "index.zip"
  function_name = "http-crud-function"
  role = aws_iam_role.iam_for_lambda.arn
  handler = "index.test"

  source_code_hash = filebase64sha256("index.zip")

  runtime = "nodejs12.x"

  environment {
    variables = {
      foo = "baar"
    }
  }
}