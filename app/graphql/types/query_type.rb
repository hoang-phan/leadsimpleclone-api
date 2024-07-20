# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :sources, resolver: Queries::Sources
    field :source, resolver: Queries::Source
    field :contacts, resolver: Queries::Contacts
    field :contact, resolver: Queries::Contact
    field :leads, resolver: Queries::Leads
    field :lead, resolver: Queries::Lead
    field :users, resolver: Queries::Users
    field :stages, resolver: Queries::Stages
  end
end
