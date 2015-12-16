class Book < ActiveRecord::Base
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :categories
  has_many :book_files
  has_many :reviews
  mount_uploader :cover, CoverUploader

  include PgSearch
  multisearchable against: [:title, :description, :isbn, :date_published, :author_names]

  def author_names
    names = []
    self.authors.each do |t|
      names << t.name
    end
    names.join(' , ')
  end
  def author_ids
    super.join("%%$$%%")
  end

  def author_ids=(ids)
    super ids.split("%%$$%%").map{|id| id.is_a?(Integer) || id.gsub(/\d+/, '') == "" ? id : Author.create(name: id).id }
  end
  def self.rebuild_pg_search_documents
    find_each { |record| record.update_pg_search_document }
  end
end
