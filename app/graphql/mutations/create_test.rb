# frozen_string_literal: true

module Mutations
  class CreateTest < BaseMutation
    argument :name, String
    argument :body, String

    field :test, Types::TestType
    field :errors, [String], null: false

    def resolve(name:, body:)
      test = Test.create(name:, body:)

      if test.save
        # Successful creation, return the created object with no errors
        {
          test: test,
          errors: [],
        }
      else
        # Failed save, return the errors to the client
        {
          test: nil,
          errors: comment.errors.full_messages
        }
      end
    end
  end
end