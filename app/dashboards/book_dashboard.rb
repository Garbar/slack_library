require "administrate/base_dashboard"

class BookDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    authors: Field::HasMany,
    categories: Field::HasMany,
    book_files: Field::HasMany,
    reviews: Field::HasMany,
    pg_search_document: Field::HasOne,
    id: Field::Number,
    title: Field::String,
    cover: Field::String,
    isbn: Field::String,
    description: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    lang: Field::String,
    published_date: Field::String,
    count_page: Field::Number,
    date_published: Field::DateTime,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :authors,
    :categories,
    :book_files,
    :reviews,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :authors,
    :categories,
    :title,
    :cover,
    :isbn,
    :description,
    :lang,
    :count_page,
    :date_published,
  ]

  # Overwrite this method to customize how books are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(book)
    "Book ##{book.isbn}-#{book.title}"
  end
end
