# frozen_string_literal: true

module Types
  class PhoneType < Types::BaseObject
    field :id, ID, null: false
    field :value, String, null: false
    field :kind, String, null: false
  end
end
