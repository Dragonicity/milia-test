class OrderMailer < ApplicationMailer

  default from: "admin@dragonicity.com"
  
  def received(order)
    @order = order

    mail to: "to@example.org"
  end

  def shipped(order)
    @order = order

    mail to: "to@example.org"
  end
end
