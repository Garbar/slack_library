class CreateBookFiles < ActiveRecord::Migration
  def change
    create_table :book_files do |t|
      t.string :title
      t.string :file
      t.string :format
      t.references :book, index: true

      t.timestamps null: false
    end
  end
end
