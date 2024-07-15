# frozen_string_literal: true

module Mutations
  class CreateOrUpdateContact < BaseMutation
    argument :id, ID, required: false
    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :company_name, String, required: false
    argument :emails_attributes, [Types::EmailInputType], required: false
    argument :phones_attributes, [Types::PhoneInputType], required: false
    argument :source_id, ID, required: true

    type Types::ContactType

    def resolve(attributes)
      attributes[:emails_attributes].map!(&:to_h)
      attributes[:phones_attributes].map!(&:to_h)
      id = attributes.delete(:id)

      contact = id.present? ? Contact.find(id) : Contact.new

      contact.tap { |record| record.update!(attributes) }
    end
  end
end
