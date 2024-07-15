# frozen_string_literal: true

module Types
  class PhoneInputType < Types::BaseInputObject
    argument :id, ID, required: false
    argument :value, String, required: true
    argument :kind, String, required: true
    argument :_destroy, String, required: false
  end
end
