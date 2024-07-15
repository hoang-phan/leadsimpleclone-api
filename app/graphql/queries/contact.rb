module Queries
  class Contact < BaseQuery
    description "Find a contact by ID"
    argument :id, ID, required: true

    type Types::ContactType, null: false

    def resolve(id:)
      ::Contact.find(id)
    end
  end
end
