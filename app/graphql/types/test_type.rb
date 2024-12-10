module Types
  class TestType < Types::BaseObject
    description "A test"
    field :id, ID, null: false
    field :name, String, null: false
    field :body, String, null: true
  end
end