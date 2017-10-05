module ApplicationHelper
   def nav_items
    [
      {
        url: root_path,
        title: 'Home'
      },
      {
        url: about_path,
        title: 'About Me'
      },
      {
        url: contact_path,
        title: 'Contact'
      } 
    ]
  end

  def nav_helper
    nav_links = ''
    nav_items.each do |item|
      nav_links << "<#{'li'}><a href='#{item[:url]}' class='#{'nav-link'} #{active? item[:url]}'>#{item[:title]}</a></#{'li'}>"
    end
    nav_links.html_safe
  end

  def active? path
    "active" if current_page? path
  end
end