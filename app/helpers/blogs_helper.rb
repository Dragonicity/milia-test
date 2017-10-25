module BlogsHelper
  
  def blog_status_text blog
    blog.draft? ? t(:publish) : t(:unpublish)
  end
  
end