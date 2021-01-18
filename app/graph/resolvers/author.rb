module Resolvers
  class Author
    attr_reader :author
    delegate_missing_to :author

    def initialize(author)
      @author = author
    end

    def books
      author.books # N+1
    end

    def books_lazy
      BatchLoader::GraphQL.for(author.id).batch do |author_ids, loader|
        Book.joins(:author)
          .where(authors: { id: author_ids })
          .each { |book| loader.call(book.id, book) }
      end
    end
  end
end
