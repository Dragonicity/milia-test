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

end