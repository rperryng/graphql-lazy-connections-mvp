class AddAuthorsAndBooksAndReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :authors do |t|
      t.string :name

      t.timestamps
    end

    create_table :books do |t|
      t.belongs_to :author, index: true

      t.string :title
      t.datetime :published_at

      t.timestamps
    end

    create_table :reviews do |t|
      t.belongs_to :book, index: true

      t.score :integer

      t.timestamps
    end
  end
end
