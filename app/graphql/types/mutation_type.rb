# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_or_update_contact, mutation: Mutations::CreateOrUpdateContact
    field :delete_contact, mutation: Mutations::DeleteContact
  end
end
