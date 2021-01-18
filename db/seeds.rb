# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

lemony_snicket, frank_herbert = Author.create([
  { name: 'Lemony Snicket' },
  { name: 'Frank Herbert' },
])

bad_beginning, reptile_room, dune, dune_messiah = Book.create([{
  author: lemony_snicket,
  title: 'The Bad Beginning',
  published_at: DateTime.parse("1999-01-01T00:00:00-05:00")
}, {
  author: lemony_snicket,
  title: 'The Reptile Room',
  published_at: DateTime.parse("1999-02-01T00:00:00-05:00")
}, {
  author: frank_herbert,
  title: 'Dune',
  published_at: DateTime.parse("1965-01-01T00:00:00-05:00")
}, {
  author: frank_herbert,
  title: 'Dune Messiah',
  published_at: DateTime.parse("1969-01-01T00:00:00-05:00")
}])

Review.create([{
  book: bad_beginning,
  score: 1,
}, {
  book: bad_beginning,
  score: 2,
}, {
  book: reptile_room,
  score: 3,
}, {
  book: reptile_room,
  score: 4,
}, {
  book: dune,
  score: 5,
}, {
  book: dune,
  score: 6,
}, {
  book: dune_messiah,
  score: 7,
}, {
  book: dune_messiah,
  score: 8,
}])
