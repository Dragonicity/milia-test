class ProductsController < ApplicationController

  before_action :set_product, only: [:show, :edit, :update, :destroy ]
  
  #access all: [:show, :index], user: {except: [:destroy]}, root_admin: :all

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
    if @product.update(product_params)
      #flash[:notice] = "#{t(:product)} #{t(:updated)}"
      redirect_to products_path
    else
      flash.now[:alert] = "#{t(:product)} #{t(:not_updated)}"
      render :edit
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
        :main_image, :price)
    end

    def set_product
      @product = Product.friendly.find(params[:id])
    end

end