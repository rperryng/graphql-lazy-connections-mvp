module Resolvers
  class Query
    def authors
      ::Author.all
    end
  end
end
