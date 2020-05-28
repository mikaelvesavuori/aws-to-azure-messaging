cd aws

# Create a deployment package
zip -r -X function.zip .

# Update Lambda function code
aws lambda update-function-code \
  --function-name $AWS_FUNCTION_NAME \
  --zip-file fileb://function.zip
