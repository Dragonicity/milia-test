class ChargesController < ApplicationController
  
  def new
  end

  def create

    amount = Cart.find(session[:cart_id]).total_price.to_i * 100

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => amount,
      :description => 'Retreat customer purchase',
      :currency    => 'usd'
    )

    purchase = Purchase.create(
      email:       params[:stripeEmail], 
      card:        params[:stripeToken],
      amount:      amount,
      description: charge.description,
      currency:    charge.currency,
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