module Queries
  class Users < BaseQuery
    description "Fetches all the users"

    type [Types::UserType], null: false

    def resolve
      ::User.order(:id)
    end
  end
end
