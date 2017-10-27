class RetreatsController < ApplicationController
  before_action :set_retreat, only: [:show, :edit, :update, :destroy ]
  access [:all, :user] => [:show, :index], teacher: :all, site_admin: :all

  def index
    @retreats = Retreat.all.reverse_date_order.paginate(page: params[:page], per_page: 3)
  end

  def show
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
      retreats = JSON.parse(resp.body).select { |retreat| retreat["categories"] == ["application"] }

      imported_retreats = 0

      retreats.each do |rbg_retreat|
        unless Retreat.exists?(rbg_id: rbg_retreat["id"].to_s)
          retreat = Retreat.new
          retreat.name              = rbg_retreat["name"]
          retreat.start_date        = rbg_retreat["start_date"]
          retreat.end_date          = rbg_retreat["end_date"]
          retreat.teachers          = rbg_retreat["teachers"].join(", ")
          retreat.program_link      = rbg_retreat["program_link"]
          retreat.registration_link = rbg_retreat["registration_link"]
          retreat.thumb_nail        = rbg_retreat["images"]["medium"]["url"]
          retreat.main_image        = rbg_retreat["images"]["large"]["url"]
          retreat.rbg_id            = rbg_retreat["id"]

          if retreat.save
            flash[:notice] = "#{t(:retreat)} #{t(:created)}"
            imported_retreats += 1
          else
            flash[:notice] = "Error in saving retreat: " + rbg_retreat.rbg_id.to_s
            render :index
          end
        end
      end
      
      flash[:notice] = imported_retreats.to_s + " retreats were imported"
      redirect_to retreats_path
    
    else
      # One or both environment variables not retrieved
      flash.now[:alert] = "Domain: #{domain} or token: #{token} not set"
      render :index
    end
  end

  private
    
    def retreat_params
      params.require(:retreat).permit(:name, :start_date, :end_date, 
        :teachers, :program_link, :registration_link, :thumb_nail, 
        :thumb_mail_cache, :main_image, :main_image_cache, :rgb_id)
    end

    def set_retreat
      @retreat = Retreat.friendly.find(params[:id])
    end

end
