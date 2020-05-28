// Reference: https://docs.microsoft.com/sv-se/azure/service-bus-messaging/service-bus-nodejs-how-to-use-queues
const { ServiceBusClient } = require("@azure/service-bus");

// Define connection string and related Service Bus entity names here
const CONNECTION_STRING = `Endpoint=sb://...;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=...`;
const QUEUE_NAME = `crosscloud-queue`;

const sbClient = ServiceBusClient.createFromConnectionString(CONNECTION_STRING);
const queueClient = sbClient.createQueueClient(QUEUE_NAME);
const sender = queueClient.createSender();

/*
SQS plain shape example:
{
  messageId: '0342f003-5b8c-41a9-a0f1-a9d7ce3bf13c',
  receiptHandle: 'AQEB64P0uDHnee+wuI/yCM+3rhRzvj7EhNUuNIr1aWm7l0BVOKOIfsryc8hY58bDzdzOUShPD7bGKgA9UQcUy3nz8L/ErSZceiNcAVJKjS+SSQZT0H/ALXJjLTR/aLgYh00SK6OWe8bLCTuj29LIcyORQdgDgpEjXbhHhUIn7e1VNDEKWuhQrP9YnEDnaQA23VtosB8nFHJ8Pd+PbikoEHX+0Zw/nGNsk5F7I26j3kbaKSdYYfM8wzmhc5tJ9q84ZO4pS3GJtcobd6+9RYVBarXP6CLf6LfAsIhe9kjKR9LKEQlPyUgTrqJ5fTWKCNDUSKcVCdHs2SdScQZmGVkcJiVTDdFK2u1hukTGy2wnpaEgl30t5/FEVKBLSWczj9j1mjuCzx9jGwdx6RKc8+FEHKMPVA==',
  body: 'asdf',
  attributes: [Object],
  messageAttributes: {},
  md5OfBody: '912ec803b2ce49e4a541068d495ab570',
  eventSource: 'aws:sqs',
  eventSourceARN: 'arn:aws:sqs:eu-north-1:123412341234:demo-sqs-queue',
  awsRegion: 'eu-north-1'
}
*/

exports.handler = async function (event, context) {
  if (!event.Records)
    return {
      statusCode: 400,
      body: JSON.stringify("Must be sent from SQS with 'Records' set!"),
    };

  if (!event.Records[0])
    return {
      statusCode: 400,
      body: JSON.stringify("Must be sent from SQS with 'Records' set!"),
    };

  const BODY = event.Records[0].body;

  const MSG_ATTR = event.Records[0].messageAttributes;

  try {
    const message = {
      body: BODY,
      //label: `Hello from the past, more exactly ${Date.now()}`,
      userProperties: {
        MSG_ATTR,
        timestamp: Date.now(),
      },
    };

    console.log(`Sending message: ${message.body}`);

    await sender.send(message);
    await queueClient.close();
  } finally {
    await sbClient.close();
  }

  return {
    body: "Done sending messages to Azure Service Bus",
    status: 200,
  };
};
