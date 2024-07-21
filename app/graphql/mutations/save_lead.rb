# frozen_string_literal: true

module Mutations
  class SaveLead < BaseMutation
    argument :id, ID, required: false
    argument :name, String, required: true
    argument :emails_sent, Integer, required: false
    argument :calls_made, Integer, required: false
    argument :assignee, Types::UserInputType, required: false
    argument :stage, Types::StageInputType, required: false
    argument :contacts, [Types::ContactInputType], required: false

    type Types::LeadType

    def resolve(attributes)
      SaveLeadService.new(attributes).call
    end
  end
end
