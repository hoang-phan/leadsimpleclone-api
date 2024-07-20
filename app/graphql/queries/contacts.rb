module Queries
  class Contacts < BaseQuery
    description "Fetches all the contacts"

    argument :filter, String, required: false

    type Types::ContactType.connection_type, null: false

    def resolve(filter: nil)
      if filter
        ::Contact.where("first_name || ' ' || last_name ilike ?", "%#{filter}%")
      else
        ::Contact.order(:id)
      end
    end
  end
end
