module BlogsHelper
  
  def blog_status_text blog
    blog.draft? ? t(:publish) : t(:unpublish)
  end

  def blog_img img, type
    if img.model.main_image? || img.model.thumb_nail?
      img
    elsif type == 'thumb'
      image_generator(height: '350', width: '200')
    else
      image_generator(height: '600', width: '400')
    end
  end

  def image_generator(height:, width:)
    "http://placehold.it/#{height}x#{width}"
  end

  def gravatar_helper user
    image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}", width: 60
  end

  require 'net/http'

  def gravatar?(user)
    gravatar_check = "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email.downcase)}.png?d=404"
    uri = URI.parse(gravatar_check)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    response.code.to_i != 404 # from d=404 parameter
  end

end