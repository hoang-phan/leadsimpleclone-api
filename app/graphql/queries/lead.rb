module Queries
  class Lead < BaseQuery
    description "Find a lead by ID"
    argument :id, ID, required: true

    type Types::LeadType, null: false

    def resolve(id:)
      ::Lead.find(id)
    end
  end
end
