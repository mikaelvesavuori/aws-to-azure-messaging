# Reference: https://docs.microsoft.com/sv-se/azure/service-bus-messaging/service-bus-quickstart-cli

# Create resource group
az group create \
  --name $AZ_RG_NAME \
  --location $AZ_LOCATION

# Create a Service bus namespace
az servicebus namespace create \
  --resource-group $AZ_RG_NAME \
  --name $AZ_NAMESPACE_NAME \
  --location $AZ_LOCATION

# Create a Service Bus queue
az servicebus queue create \
  --resource-group $AZ_RG_NAME \
  --namespace-name $AZ_NAMESPACE_NAME \
  --name $AZ_QUEUE_NAME

# Get the connection string for the namespace
connectionString=$(az servicebus namespace authorization-rule keys list --resource-group $AZ_RG_NAME --namespace-name $AZ_NAMESPACE_NAME --name RootManageSharedAccessKey --query primaryConnectionString --output tsv)