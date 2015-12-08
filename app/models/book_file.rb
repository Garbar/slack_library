class BookFile < ActiveRecord::Base
  belongs_to :book
  mount_uploader :file, FileUploader
end
