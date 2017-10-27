class TopicsController < ApplicationController
  access site_admin: :all
  before_action :set_sidebar_topics
  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
    if logged_in?(:site_admin)
      @blogs =  @topic.blogs.reverse_date_order.page(params[:page]).per(5)
    else
      @blogs = @topic.blogs.published.reverse_date_order.page(params[:page]).per(5)
    end
  end

  private
    def set_sidebar_topics
      @sidebar_topics = Topic.with_blogs
    end
end