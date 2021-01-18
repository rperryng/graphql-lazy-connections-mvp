module Resolvers
  class Author
    attr_reader :author
    delegate_missing_to :author

    def initialize(author)
      @author = author
    end

    def books_lazy
      BatchLoader::GraphQL.for(author.id).batch(default_value: []) do |author_ids, loader|
        Book.joins(:author).
          where(authors: { id: author_ids }).
          each { |book| loader.call(book.author_id) { |memo| memo << book } }
      end
    end

    def books_connection
      author.books # N+1
    end

    def books_lazy_connection
      # ???
    end
  end
end
