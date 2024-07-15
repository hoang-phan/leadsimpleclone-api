module Queries
  class Sources < BaseQuery
    description "Fetches all the sources"

    type Types::SourceType.connection_type, null: false

    def resolve
      ::Source.all
    end
  end
end
