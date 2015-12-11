class ParserService

  attr_reader :site, :book

  def initialize(site, book)
    @site = site
    @book = book
  end

  def check_book
    if ['goodreads', 'google_books'].include?(@site)
      send("parse_#{@site}".to_sym)
    end
  end

  private
  def parse_goodreads
    client = Goodreads.new
    begin
      if @book.isbn.present?
        if client.book_by_isbn(@book.isbn).is_a?(Hashie::Mash)
          @goodreadbook = client.book_by_isbn(@book.isbn)
        end
      else
        if client.book_by_title(@book.title).is_a?(Hashie::Mash)
          @goodreadbook = client.book_by_title(@book.title)
        end
      end
      if @book.authors.present? == false
        if @goodreadbook["authors"]["author"].is_a?(Array)
          @goodreadbook["authors"]["author"].each do |a|
            author = Author.find_or_create_by(name: a["name"])
            author.save
            @book.authors << author
          end
        else
          author = Author.find_or_create_by(name: @goodreadbook["authors"]["author"]["name"])
          author.save
          @book.authors << author
        end
      end
      if @book.title.present? == false
        @book.title=@goodreadbook["title"]
      end
      if @book.lang.present? == false
        @book.lang=@goodreadbook["language_code"]
      end
      if @book.description.present? == false
        @book.description=@goodreadbook["description"]
      end

      if @book.date_published.present? == false
        date_published = "#{@goodreadbook['publication_month']}/#{@goodreadbook['publication_day']}/#{@goodreadbook['publication_year']}"
        @book.date_published=date_published
      end

      if @book.cover.present? == false
        @book.remote_cover_url=@goodreadbook["image_url"]
      end
      @book.save
    end

  rescue
  end

  def parse_google_books
    if @book.isbn.present?
      books = GoogleBooks.search(book.isbn)
    else
      books = GoogleBooks.search(book.title)
    end
    begin
      gbook = books.first
      if @book.count_page.blank?
        @book.count_page = gbook.page_count
      end
      if @book.authors.present? == false
        gbook.authors_array.each do |a|
          author = Author.find_or_create_by(name: a)
          author.save
          @book.authors << author
        end
      end
      if @book.title.blank?
        @book.title=gbook.title
      end
      if @book.lang.blank?
        @book.lang=gbook.language
      end
      if @book.description.blank?
        @book.description=gbook.description
      end
      if @book.isbn.blank?
        @book.isbn=gbook.isbn
      end
      if @book.date_published.blank?
        @book.date_published=gbook.published_date
      end

      if @book.cover.blank?
        @book.remote_cover_url=gbook.image_link(:zoom => 3)
      end
      @book.save
    end

  rescue

  end


end
