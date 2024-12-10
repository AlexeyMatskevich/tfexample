Sequel.migration do
  change do

    create_table :tests do
      primary_key :id
      String :name
      Text :body
    end

  end
end
