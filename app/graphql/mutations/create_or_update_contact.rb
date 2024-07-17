# frozen_string_literal: true

module Mutations
  class CreateOrUpdateContact < BaseMutation
    argument :id, ID, required: false
    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :company_name, String, required: false
    argument :emails, [Types::EmailInputType], required: false
    argument :phones, [Types::PhoneInputType], required: false
    argument :source_id, ID, required: false

    type Types::ContactType

    def resolve(attributes)
      SaveContactService.new(attributes).call
    end
  end
end
