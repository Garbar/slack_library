class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.string :slug

      t.timestamps null: false
    end
    create_table :books_categories, id: false do |t|
      t.belongs_to :category, index: true
      t.belongs_to :book, index: true
    end
  end
end
