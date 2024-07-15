# frozen_string_literal: true

module Types
  class SourceType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
  end
end
