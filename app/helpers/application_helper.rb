module ApplicationHelper
  def scope_authors(tags)
    links = []
    if tags.count > 0
      tags.each do |t|
        links += [link_to(t.name, author_path(t))]
      end
      links.join(' &nbsp;&bull;&nbsp; ').html_safe
    end
  end

  def scope_cats(tags)
    links = []
    if tags.count > 0
      tags.each do |t|
        links += [link_to(t.title, category_path(t))]
      end
      links.join(' &nbsp;&bull;&nbsp; ').html_safe
    end
  end
end
