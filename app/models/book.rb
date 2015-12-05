class Book < ActiveRecord::Base
  has_and_belongs_to_many :authors
  before_save :check_book
  mount_uploader :cover, CoverUploader

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
          # if self.authors.present? == false
          #   if @goodreadbook["authors"]["author"].is_a?(Array)
          #     # goodreads returns author information differently depending on how
          #     # many authors there are. This block solves for errors.
          #     @goodreadbook["authors"]["author"].each do |a|
          #       puts a["name"]
          #       b = Author.find_or_create_by(name: a["name"])
          #       b.book_id = self.id
          #     end
          #   else
          #     puts @goodreadbook["authors"]["author"]["name"]
          #     b = Author.find_or_create_by(name: @goodreadbook["authors"]["author"]["name"])
          #     b.book_id = self.id
          #   end
          # end
          # these blocks test to see if the user has provided details. If they did,
          # the manual data overrides the goodreads data
          # if self.author.present? == false
          #     if @goodreadbook["authors"]["author"].is_a?(Array)
          #      # goodreads returns author information differently depending on how
          #      # many authors there are. This block solves for errors.
          #         self.author=@goodreadbook["authors"]["author"][0]["name"]
          #     else
          #         self.author=@goodreadbook["authors"]["author"]["name"]
          #     end
          # end
          if self.title.present? == false
            self.title=@goodreadbook["title"]
          end
          # puts @goodreadbook["description"]
          if self.description.present? == false
            self.description=@goodreadbook["description"]
          end
          # Me - commented out since I'm not using a description column
          # if book[:description].present? == false
          #Sanitize is a sweet gem that removes the html tags that are returned
          #in the desciption from goodreads
          #    book[:description]= Sanitize.clean(@goodreadbook["description"])
          # end

          # if book[:publisher].present? == false
          #    book[:publisher]=@goodreadbook["publisher"]
          # end

          # if book[:year].present? == false
          #    book[:year]=@goodreadbook["work"]["original_publication_year"]
          # end

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
