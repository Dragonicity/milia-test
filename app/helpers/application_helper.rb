module ApplicationHelper

  require 'net/http'

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

  def gravatar?(user)
    gravatar_check = "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email.downcase)}.png?d=404"
    uri = URI.parse(gravatar_check)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    response.code.to_i != 404 # from d=404 parameter
  end

  def gravatar_helper user
    image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}", width: 60
  end

end