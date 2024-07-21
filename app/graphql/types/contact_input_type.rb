# frozen_string_literal: true

module Types
  class ContactInputType < Types::BaseInputObject
    argument :id, ID, required: false
    argument :first_name, String, required: false
    argument :last_name, String, required: false
    argument :company_name, String, required: false
  end
end
