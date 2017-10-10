class BlogsController < ApplicationController

  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  #access all: [:show, :index], user: {except: [:destroy]}, root_admin: :all

  def index
    @blogs = Blog.all
  end

  def show
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user = current_user 
    if @blog.save
      flash[:notice] = "#{t('blog')} #{t('created')}"
      redirect_to blogs_path
    else
      flash.now[:alert] = "#{t('blog')} #{t('not_created')}"
      render :new
    end
  end

  def edit
  end

   def update
    if @blog.update(blog_params)
      flash[:notice] = "#{t('blog')} #{t('updated')}"
      redirect_to blogs_path
    else
      flash.now[:alert] = "#{t('blog')} #{t('not_updated')}"
      render :edit
    end
  end

  def destroy
    @blog.destroy
    flash[:notice] = "#{t('blog')} #{t('deleted')}"
    redirect_to blogs_path
  end

  private
    
    def blog_params
      params.require(:blog).permit(:title, :body, :thumb_nail, 
        :main_image, :status, :user_id)
    end

    def set_blog
      @blog = Blog.friendly.find(params[:id])
    end

end