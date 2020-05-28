# AWS to Azure messaging

Demo for sending messages that come to AWS SQS into an Azure Service Bus.

## Infrastructure

- AWS SQS
- AWS Lambda
- Azure Service Bus

# Prerequisites

- Account in Azure
- Account in AWS
- Logged in through your environment
- Administrator access or similar so you can create/delete resources

## Using it

No fancy stuff here. Easiest is to use the SQS console view to send some messages, and in Azure (Service Bus view) you should be able to receive messages and read them.

## Deployment

Set the vars in `vars.sh` and export them. Also take a look in the other configuration files so that you are actually setting your own account number and such.

Then deploy resources with `deploy-aws.sh` and `deploy-azure.sh`.

## Update Lambda code

Run `update-aws.sh`.

## Remove and delete resources

Use `teardown-aws.sh` and `teardown-azure.sh`.
