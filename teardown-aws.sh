aws sqs delete-queue --queue-url https://sqs.eu-north-1.amazonaws.com/123412341234/crosscloud-queue

aws iam detach-role-policy \
  --role-name $AWS_LAMBDA_ROLE_NAME \
  --policy-arn arn:aws:iam::123412341234:policy/crosscloud-message-policy

aws iam detach-role-policy \
  --role-name $AWS_LAMBDA_ROLE_NAME \
  --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole

# Delete all versions, if more than one
aws iam delete-policy-version \
  --policy-arn arn:aws:iam::123412341234:policy/crosscloud-message-policy \
  --version-id v1

# Delete default policy
aws iam delete-policy \
  --policy-arn arn:aws:iam::123412341234:policy/crosscloud-message-policy

aws lambda delete-function \
  --function-name $AWS_FUNCTION_NAME

aws iam delete-role \
  --role-name $AWS_LAMBDA_ROLE_NAME
