# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :login, mutation: Mutations::Login
    field :create_or_update_contact, mutation: Mutations::CreateOrUpdateContact
    field :delete_contacts, mutation: Mutations::DeleteContacts
  end
end
