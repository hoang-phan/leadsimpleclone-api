module Queries
  class Stages < BaseQuery
    description "Fetches all the users"

    argument :kind, String, required: false

    type [Types::StageType], null: false

    def resolve(kind: :lead)
      ::Stage.where(kind: kind).order(:order)
    end
  end
end
