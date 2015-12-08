class IsbnForm
  include ActiveModel::Model
  include Virtus.model

  attribute :isbn, String
  validates :isbn, presence: true
  validates :isbn,   :isbn_format => true
end
