# frozen_string_literal: true

module Types
  class LeadType < Types::BaseObject
    field :id, ID, null: false
    field :emails_sent, Integer, null: false
    field :calls_made, Integer, null: false
    field :stage, StageType, null: false
    field :contacts, [ContactType], null: true
    field :created_at, String, null: false
    field :assignee, UserType, null: true

    def created_at
      object.created_at.strftime("%m/%d/%y %I:%M %p")
    end
  end
end
