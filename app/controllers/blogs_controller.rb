class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy, :toggle_status]
  before_action :set_sidebar_topics, except: [:update, :create, :destroy, :toggle_status]
  access [:all, :user] => [:show, :index], teacher: :all, site_admin: :all

  def index
    @q = Blog.ransack(params[:q])
    case 
    when logged_in?(:site_admin, :teacher) && params[:tag] == nil
      @blogs = @q.result.reverse_date_order.paginate(page: params[:page], per_page: 3)
    when logged_in?(:site_admin, :teacher) && params[:tag]
      @blogs = @q.result.tagged_with(params[:tag]).reverse_date_order.paginate(page: params[:page], per_page: 3)
    when !logged_in?(:site_admin, :teacher) && params[:tag] == nil
      @blogs = @q.result.published.reverse_date_order.page(params[:page]).paginate(page: params[:page], per_page: 3)
    when !logged_in?(:site_admin, :teacher) && params[:tag]
       @blogs = @q.result.tagged_with(params[:tag]).reverse_date_order.paginate(page: params[:page], per_page: 3)
    end
  end

  def show
    if logged_in?(:site_admin, :teacher) || @blog.published?
      @blog = Blog.includes(:comments).friendly.find(params[:id])
      @comment = Comment.new
      @seo_keywords = @blog.title
    else
      redirect_to blogs_path, notice: "You are not authorised to see this page"
    end
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user = current_user 
    if @blog.save
      flash[:notice] = "#{t(:blog)} #{t(:created)}"
      redirect_to blogs_path
    else
      render :new
    end
  end

  def edit
  end

   def update
    if @blog.update(blog_params)
      flash[:notice] = "#{t(:blog)} #{t(:updated)}"
      redirect_to blogs_path
    else
      render :edit
    end
  end

  def destroy
    @blog.destroy
    flash[:notice] = "#{t(:blog)} #{t(:deleted)}"
    redirect_to blogs_path
  end

  def toggle_status
    @blog.draft? ? @blog.published! : @blog.draft!
    redirect_to blogs_path
  end

  private
    
    def blog_params
      params.require(:blog).permit(:title, :subtitle, :body, :thumb_nail, 
        :thumb_nail_cache, :main_image, :main_image_cache, :status, 
        :topic_id, :user_id, :tag_list)
    end

    def set_blog
      @blog = Blog.friendly.find(params[:id])
    end

    def set_sidebar_topics
      @sidebar_topics = Topic.with_blogs
    end

end