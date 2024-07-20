module Queries
  class Leads < BaseQuery
    description "Fetches all the leads"

    type Types::LeadType.connection_type, null: false

    def resolve
      ::Lead.order(:id)
    end
  end
end
