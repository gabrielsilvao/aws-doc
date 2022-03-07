resource "aws_apigatewayv2_api" "http-crud-api" {
  name          = "http-crud-tutorial-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_route" "http-crud-items-id-get" {
  api_id = aws_apigatewayv2_api.http-crud-api.id
  route_key = "GET /items/{id} "

  target = "integrations/${aws_lambda_function.name}"
  depends_on = [
    aws_apigatewayv2_api.http-crud-api
  ]
}

resource "aws_apigatewayv2_route" "http-crud-items-get" {
  api_id = aws_apigatewayv2_api.http-crud-api.id
  route_key = "GET /items"

  target = "integrations/${aws_lambda_function.name}"
  depends_on = [
    aws_apigatewayv2_api.http-crud-api
  ]
}

resource "aws_apigatewayv2_route" "http-crud-items-put" {
  api_id = aws_apigatewayv2_api.http-crud-api.id
  route_key = "PUT /items"

  target = "integrations/${aws_lambda_function.name}"
  depends_on = [
    aws_apigatewayv2_api.http-crud-api
  ]
}

resource "aws_apigatewayv2_route" "http-crud-items-id-delete" {
  api_id = aws_apigatewayv2_api.http-crud-api.id
  route_key = "DELETE /items/{id}"
  
  target = "integrations/${aws_lambda_function.name}"
  depends_on = [
    aws_apigatewayv2_api.http-crud-api
  ]
}