# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Book.delete_all
# Book.create!(isbn: '9781941222126')
require 'googlebooks' # unless you're using Bundler
results = GoogleBooks.search('ruby', :count => 30)
puts "Total results for the term 'ruby': #{results.count}"
for book in results
  @book = Book.create(title: book.title, isbn: book.isbn, lang: book.language,
                      published_date: book.published_date,
                      description: book.description, remote_cover_url: book.image_link(:zoom => 2))
  book.authors_array.each do |a|
    author = Author.find_or_create_by(:name => a)
    author.save
    @book.authors << author
  end
end
