module ApplicationHelper

  def nav_items
    [
      {
        url: retreats_path,
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
      },
      {
        url: teachers_path,
        title: t(:teachers)
      },
      {
        url: about_path,
        title: t(:about)
      },
      {
        url: new_contact_path,
        title: t(:contact)
      }
    ]
  end

  def nav_helper
    nav_links = ''
    nav_items.each do |item|
      nav_links << "<#{'li class="nav-item"'}><a href='#{item[:url]}' class='#{'nav-link'} #{active? item[:url]}'>#{item[:title]}</a></#{'li'}>"
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

  def set_img img, type
    if img.model.main_image? && type == 'main' && type != 'thumb'
      img.model.main_image
    elsif img.model.thumb_nail? && type == 'thumb'
      img.model.thumb_nail
    elsif type == 'thumb'
      image_generator(height: '350', width: '200')
    else
      image_generator(height: '600', width: '400')
    end
  end

  def image_generator(height:, width:)
    "http://placehold.it/#{height}x#{width}"
  end

end