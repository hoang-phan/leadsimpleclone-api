module Queries
  class Source < BaseQuery
    description "Find a source by ID"
    argument :id, ID, required: true

    type Types::SourceType, null: false

    def resolve(id:)
      ::Source.find(id)
    end
  end
end
