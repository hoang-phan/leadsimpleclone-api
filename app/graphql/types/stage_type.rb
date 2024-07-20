# frozen_string_literal: true

module Types
  class StageType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :color, String, null: false
  end
end
