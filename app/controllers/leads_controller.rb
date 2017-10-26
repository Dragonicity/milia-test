class LeadsController < ApplicationController
  
  def create
    @lead = Lead.new(lead_params)
    
    if @lead.save
      redirect_to root_path, notice: "Thank you for signing up"
    else
      render 'pages/home'
    end
  
  end

  private

  def lead_params
    params.require(:lead).permit(:first_name, :last_name, :email)
  end

end