# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_test, mutation: Mutations::CreateTest, description: "An example create test"
  end
end
