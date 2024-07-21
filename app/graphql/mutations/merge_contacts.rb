# frozen_string_literal: true

module Mutations
  class MergeContacts < BaseMutation
    argument :contact_ids, [ID], required: true
    argument :primary_contact_id, ID, required: true

    field :success, Boolean, null: false

    def resolve(contact_ids:, primary_contact_id:)
      MergeContactsService.new(contact_ids:, primary_contact_id:).call
      { success: true }
    end
  end
end
