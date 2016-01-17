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

  def auth_slack_link(title = 'Slack')
    if request.env['PATH_INFO'] == '/'
      link_to title, '/auth/slack'
    else
      link_to title, "/auth/slack?origin=#{request.env['PATH_INFO']}"
    end
  end
end
