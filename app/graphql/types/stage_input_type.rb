# frozen_string_literal: true

module Types
  class StageInputType < Types::BaseInputObject
    argument :id, ID, required: true
    argument :name, String, required: false
    argument :color, String, required: false
  end
end
