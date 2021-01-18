# Twhis file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
