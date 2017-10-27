class ProductsController < ApplicationController
  include SetCurrentCart
  before_action :set_cart, only: [:update]
  before_action :set_product, only: [:show, :edit, :update, :destroy ]
  access [:all, :user] => [:show, :index], teacher: :all, site_admin: :all

  def index
    @products = Product.all
  end

  def show
    @seo_keywords = @product.title
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "#{t(:product)} #{t(:created)}"
      redirect_to products_path
    else
      #flash.now[:alert] = "#{t(:product)} #{t(:not_created)}"
      render :new
    end
  end

  def edit
  end

   def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product,
          notice: "#{t(:product)} #{t(:updated)}" }
        format.json { render :show, status: :ok, location: @product }
        
        @products = Product.all 
        ActionCable.server.broadcast 'products',
          html: render_to_string('store/index', layout: false)
      else
        flash.now[:alert] = "#{t(:product)} #{t(:not_updated)}"
        render :edit
      end
    end
  end

  def destroy
    @product.destroy
    flash[:notice] = "#{t(:product)} #{t(:deleted)}"
    redirect_to products_path
  end

  private
    
    def product_params
      params.require(:product).permit(:title, :description, :thumb_nail, 
        :thumb_nail_cache, :main_image, :main_image_cache, :price)
    end

    def set_product
      @product = Product.friendly.find(params[:id])
    end

    def who_bought
      @product = Product.find(params[:id])
      @latest_order = @product.orders.order(:updated_at).last
      if stale?(@latest_order)
        respond_to do |format|
          format.atom
        end
      end
    end
end