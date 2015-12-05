class AddFieldsToBooks < ActiveRecord::Migration
  def change
    add_column :books, :lang, :string
    add_column :books, :published_date, :string
  end
end
