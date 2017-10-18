class PagesController < ApplicationController
  def home
  end

  def about
  end

  def contact
  end


  # Controller action for the view to be used to show retreat info

  def retreat
    # Get the envrionment variables
    domain = ENV['RGBDOMAIN']
    token  = ENV['RGBTOKEN']

    if domain && token
      # Environment variables successfully retrieved
      # Create the url to access the data on the API

      $url = "http://#{domain}/api/v1/programs?token=#{token}"

      
    else
      # One or both environment variables not retrieved
    
      flash.now[:alert] = "Domain: #{domain} or token: #{token} not set"
      render :retreat
    
    end

  end

  def services
  end

  def products
  end

  def terms_of_service
  end

  def privacy_policy
  end
end
