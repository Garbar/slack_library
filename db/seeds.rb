# ActiveRecord::Base.connection.execute("TRUNCATE #{:pg_search_documents}")
# ActiveRecord::Base.connection.execute("TRUNCATE #{:authors_books}")
# ActiveRecord::Base.connection.execute("TRUNCATE #{:books_categories}")
# ActiveRecord::Base.connection.execute("TRUNCATE #{:books}")
# ActiveRecord::Base.connection.execute("TRUNCATE #{:authors}")
# ActiveRecord::Base.connection.execute("TRUNCATE #{:reviews}")
require 'database_cleaner'
DatabaseCleaner.clean_with(:truncation, :except => %w[users schema_migrations])

require 'csv'

csv_text = File.read(Rails.root.join('db', 'it_books.csv'))
csv = CSV.parse(csv_text, :headers => true)
csv.to_a.map do|row|
  b = Book.create!(title: row[0], isbn: row[1])
  ParserService.new("google_books", b).check_book
end
