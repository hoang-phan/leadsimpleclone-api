# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :login, mutation: Mutations::Login
    field :save_contact, mutation: Mutations::SaveContact
    field :delete_contacts, mutation: Mutations::DeleteContacts
    field :save_lead, mutation: Mutations::SaveLead
    field :delete_leads, mutation: Mutations::DeleteLeads
  end
end
