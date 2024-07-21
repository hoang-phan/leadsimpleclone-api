# frozen_string_literal: true

module Mutations
  class CreateLeadsFromContacts < BaseMutation
    argument :contact_ids, [ID], required: true
    argument :stage_id, ID, required: true
    argument :assignee_id, ID, required: true

    field :success, Boolean, null: false

    def resolve(contact_ids:, stage_id:, assignee_id:)
      CreateLeadsFromContactsService.new(contact_ids:, stage_id:, assignee_id:).call
      { success: true }
    end
  end
end
