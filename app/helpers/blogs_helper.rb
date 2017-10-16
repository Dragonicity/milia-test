module BlogsHelper
  def gravatar_helper user
    image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}", width: 60
  end

  
  def blog_status_text blog
    blog.draft? ? t(:publish) : t(:unpublish)
  end

  def blog_status_colour blog
    blog.draft? ? 'color: red;' :  'color: blue'
  end
end