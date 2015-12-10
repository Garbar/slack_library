class AddDateToBooks < ActiveRecord::Migration
  def change
    add_column :books, :count_page, :integer
    add_column :books, :date_published, :datetime
  end
end
