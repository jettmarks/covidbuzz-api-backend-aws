data "template_file" "tcn_api_swagger" {
  template = file(var.api_spec_path_v4)

  vars = {
    lambda_invoke_arn = aws_lambda_function.tcn_lambda.invoke_arn
  }
}

resource "aws_api_gateway_rest_api" "tcn_api_gateway" {
  name        = "tcn_api_gateway"
  description = "API Gateway for TCN Server backend"
  body        = data.template_file.tcn_api_swagger.rendered

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "tcn_lambda_gateway" {
  rest_api_id = aws_api_gateway_rest_api.tcn_api_gateway.id
  stage_name  = "v4"
}
