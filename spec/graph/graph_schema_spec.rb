describe GraphSchema do
  describe 'execute' do
    subject { GraphSchema.execute(query, variables) }

    before do
      ActiveRecord::Base.logger = Logger.new(STDOUT)

      madeline_miller, frank_herbert = Author.create([
        { name: 'Madeline Miller' },
        { name: 'Frank Herbert' },
      ])

      the_song_of_achilles, reptile_room, dune, dune_messiah = Book.create([{
        author: madeline_miller,
        title: 'The Song of Achilles',
        published_at: DateTime.parse("2011-01-01T00:00:00-05:00")
      }, {
        author: madeline_miller,
        title: 'Circe',
        published_at: DateTime.parse("2018-02-01T00:00:00-05:00")
      }, {
        author: frank_herbert,
        title: 'Dune',
        published_at: DateTime.parse("1965-01-01T00:00:00-05:00")
      }, {
        author: frank_herbert,
        title: 'Dune Messiah',
        published_at: DateTime.parse("1969-01-01T00:00:00-05:00")
      }])
    end

    let(:query) { raise NotImplementedError }
    let(:variables) { {} }

    context 'books_connection' do
      let(:query) do
        <<~GQL
        query testQuery {
          authors(first: 2) {
            nodes {
              name
              books_connection {
                nodes {
                  title
                }
              }
            }
          }
        }
        GQL
      end

      it 'makes n+1 requests' do
        # Verified using active record logs
        subject
      end
    end

    context 'books_lazy' do
      let(:query) do
        <<~GQL
        query testQuery {
          authors(first: 2) {
            nodes {
              name
              books_lazy {
                title
              }
            }
          }
        }
        GQL
      end

      it 'makes 1 query' do
        # Verified using active record logs
        subject
      end
    end

    context 'books_lazy_connection' do
      let(:query) do
        <<~GQL
        query testQuery {
          authors(first: 2) {
            nodes {
              name
              books_lazy_connection {
                nodes {
                  title
                }
              }
            }
          }
        }
        GQL
      end

      it 'makes 1 query' do
        # Can't resolve.
        subject
      end
    end
  end
end
