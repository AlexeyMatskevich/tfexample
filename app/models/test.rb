class Test < Sequel::Model
  def after_create
    Pulsar::TestProducer.newMessage.value(Java.type('java.lang.String').new(self.name))['send'].call

    super
  end
end
