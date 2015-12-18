module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper
  def scope_authors(tags)
    links = []
    tags.each do |t|
      links += [link_to(t.name, author_path(t))]
    end
    links.join(' &nbsp;&bull;&nbsp; ').html_safe
  end

  def scope_cats(tags)
    links = []
    tags.each do |t|
      links += [link_to(t.title, category_path(t))]
    end
    links.join(' &nbsp;&bull;&nbsp; ').html_safe
  end
end
