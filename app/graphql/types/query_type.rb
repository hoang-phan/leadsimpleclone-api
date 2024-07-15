# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :sources, resolver: Queries::Sources
    field :source, resolver: Queries::Source
    field :contacts, resolver: Queries::Contacts
    field :contact, resolver: Queries::Contact
  end
end
