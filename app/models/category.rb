class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  def should_generate_new_friendly_id?
    if !slug? || title_changed?
      true
    else
      false
    end
  end
  has_and_belongs_to_many :books
end
