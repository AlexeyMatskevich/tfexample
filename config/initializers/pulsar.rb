unless ENV['SKIP_PULSAR']
  Java.add_to_classpath("/app/pulsar-java-client/lib/build/libs/lib-all.jar")

  module Pulsar
    Pulsar = Java.type('org.apache.pulsar.client.api.PulsarClient') # Get pulsar client
    Schema = Java.type('org.apache.pulsar.client.api.Schema')
    Client = Pulsar.builder.serviceUrl(ENV["PULSAR_URL"]).build # Greate client
    TestProducer = Client
                     .newProducer(Schema['STRING'])
                     .topic("my-topic")
                     .create
    TestConsumer = Client
                     .newConsumer(Pulsar::Schema['STRING'])
                     .topic("my-topic")
                     .subscriptionName("my-subscription")
                     .subscriptionType(Java.type('org.apache.pulsar.client.api.SubscriptionType').Exclusive)
                     .subscribe
  end
end