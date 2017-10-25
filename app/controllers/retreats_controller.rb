class RetreatsController < ApplicationController
  before_action :set_retreat, only: [:show, :edit, :update, :destroy ]
  #access all: [:show, :index], user: {except: [:destroy]}, root_admin: :all

  def index
    @retreats = Retreat.all.reverse_date_order.page(params[:page]).per(3)
  end

  def show
    @seo_keywords = @retreat.name
  end

  def new
    @retreat = Retreat.new
  end

  def create
    @retreat = Retreat.new(retreat_params)
    if @retreat.save
      flash[:notice] = "#{t(:retreat)} #{t(:created)}"
      redirect_to retreats_path
    else
      render :index
    end
  end

  def edit
  end

   def update
    if @retreat.update(retreat_params)
      flash[:notice] = "#{t(:retreat)} #{t(:updated)}"
      redirect_to blogs_path
    else
      render :edit
    end
  end

  def destroy
    @retreat.destroy
    flash[:notice] = "#{t(:retreat)} #{t(:deleted)}"
    redirect_to retreats_path
  end

  def import
    domain = ENV['RGBDOMAIN']
    token  = ENV['RGBTOKEN']

    if domain && token
      url = "#{domain}#{token}"
      resp = Net::HTTP.get_response(URI.parse(url))
      @retreats = JSON.parse(resp.body).select { |retreat| retreat["categories"] == ["application"] }

      imported_retreats = 0

      @retreats.each do |rgb_retreat|
        retreat = Retreat.new
        retreat.name              = rgb_retreat.name
        retreat.start_date        = rgb_retreat.start_date
        retreat.end_date          = rgb_retreat.end_date
        retreat.teachers          = rgb_retreat.teachers.to_s
        retreat.program_link      = rgb_retreat.program_link
        retreat.registration_linl = rgb_retreat.registration_link
        retreat.thumb_nail        = rgb_retreat.thumb_nail
        retreat.main_image        = rgb_retreat.main_image
        retreat.rgb_id            = rgb_retreat.rgb_id

        if @retreat.save
          flash[:notice] = "#{t(:retreat)} #{t(:created)}"
          imported_retreats += 1
        else
          flash[:notice] = "Error in saving retreat: " + rgb_retreat.rgb_id
          render :index
        end
      end
      
      flash[:notice] = imported_retreats + " were imported"
      redirect_to retreats_path
    
    else
      # One or both environment variables not retrieved
      flash.now[:alert] = "Domain: #{domain} or token: #{token} not set"
      render :index
    end
  end

  private
    
    def retreat_params
      params.require(:retreat).permit(:name, :start_date, :end_date, :teachers, :program_link, :registration_link, :thumb_nail, 
        :main_image, :rgb_id)
    end

    def set_retreat
      @retreat = Retreat.friendly.find(params[:id])
    end

end
