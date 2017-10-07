class ContactMailer < ApplicationMailer

  default to: "Mark Nelson <mark.nelson@dragonicity.com>"

  def contact_message(contact)
    @message = contact
    mail(from: %("#{contact.name} <#{contact.email}>"), phone: "contact.phone", 
      subject: "#{contact.name}", message: "#{contact.message}")
  end
end