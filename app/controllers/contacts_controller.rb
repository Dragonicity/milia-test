class ContactsController < ApplicationController
 #skip_before_action :authenticate_user!

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.valid?
      ContactMailer.contact_message(@contact).deliver
      redirect_to new_contact_path, notice: t(:contact_message_sent)
    else
      flash[:alert] = t(:contact_message_error)
      render 'new'
    end
  end

private

  def contact_params
    params.require(:contact).permit(:name, :email, :phone, :subject, :message)
  end

end