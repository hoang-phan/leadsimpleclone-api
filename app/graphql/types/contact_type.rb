# frozen_string_literal: true

module Types
  class ContactType < Types::BaseObject
    field :id, ID, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :company_name, String
    field :emails, [EmailType]
    field :phones, [PhoneType]
    field :source, SourceType
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
