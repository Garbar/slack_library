class ParserService
  include ActiveModel::Model
  include Virtus.model

  attribute :isbn, String
  validates :isbn, presence: true

  def check_book
    @book = Book.find_or_create_by(isbn: @isbn)
  end

  private
  def parse_goodreads(book)

  end
end
