# Setup
you need any ruby to install dip and docker, or just use docker compose up/etc, see dip.yaml provision block for details.
```bash
gem install dip
dip provision
dip up
```

[//]: # (# How to send messages)

[//]: # (```ruby)

[//]: # (Java.add_to_classpath&#40;"/app/pulsar-java-client/lib/build/libs/lib-all.jar"&#41; # Load dependency)

[//]: # (pulsar = Java.type&#40;'org.apache.pulsar.client.api.PulsarClient'&#41; # Get pulsar client)

[//]: # (schema = Java.type&#40;'org.apache.pulsar.client.api.Schema'&#41; # Get schema types to define producer)

[//]: # (client = pulsar.builder.serviceUrl&#40;ENV["PULSAR_URL"]&#41;.build # Greate client)

[//]: # ()
[//]: # (# This is an example of data transfer in string format)

[//]: # (producer = client.newProducer&#40;schema['STRING']&#41;.topic&#40;"my-topic"&#41;.create # Create producer)

[//]: # (producer.newMessage&#40;&#41;.value&#40;Java.type&#40;'java.lang.String'&#41;.new&#40;"Hello world2"&#41;&#41;.sendAsync # Send message Async)

[//]: # (```)

# How to test?
Execute GraphQL mutation from rails console
```ruby
query_string = "
mutation {
  createTest(input: {name: \"Test foobar\", body: \"Test Body1\"}) {
    test {
      name
      body
    }
    errors
  }
}"

ApiSchema.execute(query_string)
```

or send 
```js
fetch('http://localhost:3001/graphql', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  },
  body: JSON.stringify({
    query: `
      mutation {
        createTest(input: {name: "Test foobar3", body: "Test Body3"}) {
          test {
            name
            body
          }
          errors
        }
      }
    `
  })
})
  .then(response => response.json())
  .then(data => console.log(data))
  .catch(error => console.error('Error:', error));
```
open console `dip rails c` execute code to consume message from pulsar 'my-topic'
```ruby
message = Pulsar::TestConsumer.receive
message.getValue
# => "Test foobar"
```


# How it works?
1. This example uses TruffleRuby, which is based on GraalVM. GraalVM enables running LLVM-based languages (C++/Rust/etc.), Java, Ruby, Python, and JavaScript, allowing all of this code to interoperate within a single file. The installation of TruffleRuby is shown at `.dockerdev/Dockerfile:44`.
2. All Ruby code works as usual, and everything is installed via bundle.
3. The Java code is located in pulsar-java-client/lib and is packaged using Gradle. Gradle installation is shown at `.dockerdev/Dockerfile:57`.
4. The Java code is integrated into the Ruby code in `config/initializers/pulsar.rb`. The `Java.add_to_classpath` method loads the code packaged with Gradle into the library. You can then see how this code is used in the same file.
5. To demonstrate a toy example of using TruffleRuby, I utilized the Pulsar message broker. Its installation is located at `.dockerdev/compose.yml:54`. Configuration is done in `pulsar.rb`. After that, we create messages when running tests in `app/models/test.rb:3` and can consume messages in any way we prefer. I demonstrate how to do this through the Rails console above.