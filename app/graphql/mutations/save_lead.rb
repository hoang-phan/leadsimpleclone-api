# frozen_string_literal: true

module Mutations
  class SaveLead < BaseMutation
    argument :id, ID, required: false
    argument :name, String, required: false
    argument :emails_sent, Integer, required: false
    argument :calls_made, Integer, required: false
    argument :assignee_id, ID, required: false
    argument :stage_id, ID, required: false
    argument :contact_ids, [ID], required: false

    type Types::LeadType

    def resolve(attributes)
      SaveLeadService.new(attributes).call
    end
  end
end
