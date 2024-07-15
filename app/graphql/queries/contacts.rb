module Queries
  class Contacts < BaseQuery
    description "Fetches all the contacts"

    type Types::ContactType.connection_type, null: false

    def resolve
      ::Contact.all
    end
  end
end
