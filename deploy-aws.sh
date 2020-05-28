# Create SQS queue
aws sqs create-queue \
--queue-name $AWS_QUEUE_NAME

# Create the execution role
aws iam create-role --role-name $AWS_LAMBDA_ROLE_NAME --assume-role-policy-document file://policy-trust.json

# Create the custom policy, so Lambda can use SQS
aws iam create-policy \
  --policy-name $AWS_LAMBDA_POLICY_NAME \
  --policy-document file://policy-sqs.json

# Add permissions to the role
aws iam attach-role-policy --role-name $AWS_LAMBDA_ROLE_NAME --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole
aws iam attach-role-policy --role-name $AWS_LAMBDA_ROLE_NAME --policy-arn arn:aws:iam::123412341234:policy/crosscloud-message-policy

# Create a deployment package
cd aws
zip -r -X function.zip .

# Create Lambda function
aws lambda create-function \
  --function-name $AWS_FUNCTION_NAME \
  --zip-file fileb://function.zip \
  --handler index.handler \
  --runtime nodejs12.x \
  --role $AWS_LAMBDA_ROLE_NAME

# Create event source mapping
# event-source-arn is ARN of SQS queue
aws lambda create-event-source-mapping \
  --event-source-arn arn:aws:sqs:eu-north-1:123412341234:crosscloud-queue \
  --function-name $AWS_FUNCTION_NAME

# Call function
# aws lambda invoke --function-name $AWS_FUNCTION_NAME out --log-type Tail --query 'LogResult' --output text |  base64 -d