module Resolvers
  class TestResolver < BaseResolver
    type Types::TestType, null: false
    argument :id, ID

    def resolve(id:)
      ::Test.find(id.to_i).first
    end
  end
end