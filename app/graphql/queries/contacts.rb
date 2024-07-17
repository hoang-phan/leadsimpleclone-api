module Queries
  class Contacts < BaseQuery
    description "Fetches all the contacts"

    type Types::ContactType.connection_type, null: false

    def resolve
      ::Contact.order(:id)
    end
  end
end
