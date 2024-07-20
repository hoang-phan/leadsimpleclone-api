# frozen_string_literal: true

module Types
  class LeadType < Types::BaseObject
    field :id, ID, null: false
    field :emails_sent, Integer, null: false
    field :calls_made, Integer, null: false
    field :stage, StageType, null: false
    field :contacts, [ContactType]
    field :created_at, String, null: false

    def created_at
      object.created_at.strftime("%m/%d/%y %I:%M %p")
    end
  end
end
