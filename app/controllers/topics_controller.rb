class TopicsController < ApplicationController
  before_action :set_sidebar_topics

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
    @q = Blog.ransack(params[:q])
    if logged_in?(:site_admin, :teacher)
      @blogs =  @topic.blogs.reverse_date_order.paginate(page: params[:page], per_page: 3)
    else
      @blogs = @topic.blogs.published.reverse_date_order.paginate(page: params[:page], per_page: 3)
    end
  end

  private
    def set_sidebar_topics
      @sidebar_topics = Topic.with_blogs
    end
end