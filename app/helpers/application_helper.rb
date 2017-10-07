module ApplicationHelper
   def nav_items
    [
      {
        url: about_path,
        title: t(:about)
      },
      {
        url: new_contact_path,
        title: t(:contact)
      }, 
      {
        url: retreat_path,
        title: t(:retreat)
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