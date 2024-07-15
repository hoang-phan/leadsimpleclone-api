# frozen_string_literal: true

module Mutations
  class DeleteContact < BaseMutation
    argument :id, ID, required: true

    field :success, Boolean, null: false

    def resolve(id:)
      Contact.find(id).destroy!
      { success: true }
    end
  end
end
