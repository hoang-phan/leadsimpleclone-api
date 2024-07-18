# frozen_string_literal: true

module Mutations
  class DeleteContacts < BaseMutation
    argument :ids, [ID], required: true

    field :success, Boolean, null: false

    def resolve(ids:)
      Contact.where(id: ids).destroy_all
      { success: true }
    end
  end
end
