# frozen_string_literal: true

module Types
  class ContactType < Types::BaseObject
    field :id, ID, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :name, String, null: false
    field :company_name, String
    field :emails, [EmailType]
    field :phones, [PhoneType]
    field :source, SourceType
    field :created_at, String, null: false
    field :leads_count, Integer, null: false

    def created_at
      object.created_at.strftime("%m/%d/%y")
    end

    def leads_count
      object.leads.count
    end
  end
end
