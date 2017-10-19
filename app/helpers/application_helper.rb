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
        title: t(:retreats)
      },
      {
        url: services_path,
        title: t(:services)
      },
      {
        url: products_path,
        title: t(:products)
      },
      {
        url: store_index_path,
        title: t(:store),
      },
      {
        url: blogs_path,
        title: t(:blog)
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

  def required?(obj, attr)
    target = (obj.class == Class)? obj : obj.class
    target.validators_on(attr).map(&:class).include?(
      ActiveRecord::Validations::PresenceValidator)
  end


end