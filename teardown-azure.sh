az servicebus queue delete \
  --resource-group $AZ_RG_NAME \
	--namespace-name $AZ_NAMESPACE_NAME \
  --name $AZ_QUEUE_NAME

az servicebus namespace delete \
  --resource-group $AZ_RG_NAME \
  --name $AZ_NAMESPACE_NAME

az group delete \
  --resource-group $AZ_RG_NAME