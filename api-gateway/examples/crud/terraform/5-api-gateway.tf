resource "aws_apigatewayv2_api" "http-crud-api" {
  name          = "http-crud-api"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "http-crud-api" {
  api_id           = aws_apigatewayv2_api.http-crud-api.id
  integration_type = "AWS_PROXY"

  integration_method = "POST"
  integration_uri    = aws_lambda_function.http-crud-function.invoke_arn
  depends_on = [
    aws_apigatewayv2_api.http-crud-api
  ]
}


resource "aws_apigatewayv2_route" "http-crud-items-get" {
  api_id = aws_apigatewayv2_api.http-crud-api.id
  route_key = "GET /items"

  target = "integrations/${aws_apigatewayv2_integration.http-crud-api.id}"
  depends_on = [
    aws_apigatewayv2_integration.http-crud-api
  ]
}

resource "aws_apigatewayv2_route" "http-crud-items-put" {
  api_id = aws_apigatewayv2_api.http-crud-api.id
  route_key = "PUT /items"

  target = "integrations/${aws_apigatewayv2_integration.http-crud-api.id}"
  depends_on = [
    aws_apigatewayv2_integration.http-crud-api
  ]
}

resource "aws_apigatewayv2_route" "http-crud-items-id-get" {
  api_id = aws_apigatewayv2_api.http-crud-api.id
  route_key = "GET /items/{id} "

  target = "integrations/${aws_apigatewayv2_integration.http-crud-api.id}"
  depends_on = [
    aws_apigatewayv2_integration.http-crud-api
  ]
}

resource "aws_apigatewayv2_route" "http-crud-items-id-delete" {
  api_id = aws_apigatewayv2_api.http-crud-api.id
  route_key = "DELETE /items/{id}"

  target = "integrations/${aws_apigatewayv2_integration.http-crud-api.id}"
  depends_on = [
    aws_apigatewayv2_integration.http-crud-api
  ]
}