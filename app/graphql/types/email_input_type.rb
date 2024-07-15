# frozen_string_literal: true

module Types
  class EmailInputType < Types::BaseInputObject
    argument :id, ID, required: false
    argument :value, String, required: false
    argument :kind, String, required: false
    argument :_destroy, String, required: false
  end
end
