SCHEMA = <<-GQL
schema {
  query: Query
}

type Query {
  authors(
    after: String
    before: String
    first: Int
    last: Int
  ): AuthorConnection
}

type Author {
  name: String

  books_lazy: [Book]

  books_connection(
    after: String
    before: String
    first: Int
    last: Int
  ): BookConnection

  books_lazy_connection(
    after: String
    before: String
    first: Int
    last: Int
  ): BookConnection
}

type Book {
  title: String
  published_at: String
}

type AuthorConnection {
  edges: [AuthorEdge]
  nodes: [Author]
  pageInfo: PageInfo!
}

type BookConnection {
  edges: [BookEdge]
  nodes: [Book]
  pageInfo: PageInfo!
}

type AuthorEdge {
  cursor: String!
  node: Author
}

type BookEdge {
  cursor: String!
  node: Book
}

type PageInfo {
  endCursor: String
  hasNextPage: Boolean!
  hasPreviousPage: Boolean!
  startCursor: String
}
GQL

GraphSchema = GraphQL::Schema.from_definition(
  SCHEMA,
  default_resolve: SchemaImplementation.new,
  using: {
    BatchLoader::GraphQL => nil,
    GraphQL::Pagination::Connections => nil,
  }
)
