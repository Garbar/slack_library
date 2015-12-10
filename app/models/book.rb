class Book < ActiveRecord::Base
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :categories
  has_many :book_files
  has_many :reviews
  before_save :check_book
  mount_uploader :cover, CoverUploader

  def author_ids
    super.join("%%$$%%")
  end

  def author_ids=(ids)
    super ids.split("%%$$%%").map{|id| id.is_a?(Integer) || id.gsub(/\d+/, '') == "" ? id : Author.create(name: id).id }
  end

  def check_book
    if self.isbn.present?
      # initializes access to Goodreads with authentication.
      client = Goodreads.new
      # this begin/rescue pair tests for errors if goodreads does not return
      # any book information and allows the user to enter the data manually.
      begin

        # this block checks to see if an ISBN was provided. If it was, any empty field
        # is populated with Goodreads data.

        if client.book_by_isbn(self.isbn).is_a?(Hashie::Mash)
          @goodreadbook = client.book_by_isbn(self.isbn)
          # this is for debugging purposes and is not visible to the user
          if self.authors.present? == false
            if @goodreadbook["authors"]["author"].is_a?(Array)
              @goodreadbook["authors"]["author"].each do |a|
                author = Author.find_or_create_by(name: a["name"])
                author.save
                self.authors << author
              end
            else
              author = Author.find_or_create_by(name: @goodreadbook["authors"]["author"]["name"])
              author.save
              self.authors << author
            end
          end
          if self.title.present? == false
            self.title=@goodreadbook["title"]
          end
          if self.lang.present? == false
            self.lang=@goodreadbook["language_code"]
          end
          if self.description.present? == false
            self.description=@goodreadbook["description"]
          end

          if self.date_published.present? == false
            date_published = "#{@goodreadbook['publication_month']}/#{@goodreadbook['publication_day']}/#{@goodreadbook['publication_year']}"
            # self.published_date=@goodreadbook["work"]["original_publication_year"]
            self.date_published=date_published
          end

          # :picture is user uploaded img, :goodreadscover is the picture from goodreads
          if self.cover.present? == false
            puts self.remote_cover_url=@goodreadbook["image_url"]
          end
        end

      rescue
      end
    end
  end

end
