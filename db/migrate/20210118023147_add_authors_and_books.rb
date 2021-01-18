class AddAuthorsAndBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :authors do |t|
      t.string :name, null: false

      t.timestamps
    end

    create_table :books do |t|
      t.belongs_to :author, index: true

      t.string :title, null: false
      t.datetime :published_at, null: false

      t.timestamps
    end
  end
end
