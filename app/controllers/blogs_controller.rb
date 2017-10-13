class BlogsController < ApplicationController

  before_action :set_blog, only: [:show, :edit, :update, :destroy, :toggle_status]
  before_action :set_sidebar_topics, except: [:update, :create, :destroy, :toggle_status]
  #access all: [:show, :index], user: {except: [:destroy]}, root_admin: :all

  def index
    if logged_in?(:site_admin)
      @blogs = Blog.reverse_date_order.page(params[:page]).per(3)
    else
        @blogs = Blog.published.reverse_date_order.page(params[:page]).per(3)
    end
  end

  def show
    if logged_in?(:site_admin) || @blog.published?
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
      flash.now[:alert] = "#{t(:blog)} #{t(:not_created)}"
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
      flash.now[:alert] = "#{t(:blog)} #{t(:not_updated)}"
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
      params.require(:blog).permit(:title, :body, :thumb_nail, 
        :main_image, :status, :topic_id, :user_id)
    end

    def set_blog
      @blog = Blog.friendly.find(params[:id])
    end

    def set_sidebar_topics
      @sidebar_topics = Topic.with_blogs
    end

end