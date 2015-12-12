class Author < ActiveRecord::Base
  has_and_belongs_to_many :books
  # include PgSearch
  # multisearchable against: :name
end
