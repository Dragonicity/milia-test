class SubscriptionsController < ApplicationController
  
  def new
  end

  def create

    # Amount in cents
    @amount = 700

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken],
      :plan => "RetreatSubPlanId"
    )

    purchase = Purchase.create(
      email:       params[:stripeEmail], 
      card:        params[:stripeToken],
      amount:      @amount,
      description: "Retreat Subscription",
      currency:    "usd",
      customer_id: customer.id,
      product_id:  1,
      uuid: SecureRandom.uuid
    )

    redirect_to purchase

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end