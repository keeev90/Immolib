class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def create
    @price = params[:price].to_d
    @property = params[:property]
    customer = Stripe::Customer.create

    @session = Stripe::Checkout::Session.create(
      customer: customer.id,
      payment_method_types: ['card'],
      line_items: [
        {
          name: "Immolib - Fini la galère. Bonjour l'organisation de vos visites simple et efficace.",
          amount: (@price*100).to_i,
          currency: 'eur',
          quantity: 1
        },
      ],
      mode: 'payment',
      metadata: [@property.to_s],
      success_url: checkout_success_url + "?property=#{@property}&session_id={CHECKOUT_SESSION_ID}",
      cancel_url: checkout_cancel_url
    )
    respond_to do |format|
      format.js # renders create.js.erb
    end
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    @property = Property.find(params[:property])

    puts "#" * 60
    puts @property
    puts "#" * 60
    puts @session.metadata
    puts "#" * 60

    # TO DO : 

    #migrations : 
    #add "payment_success" (boolean) to Property model
    #add "stripe_customer_id" (integer) to User model

    #if @session.payment_status = "paid"
    # Property.find(@session.metadata["0"].to_i).update(payment_success: true) 
    # User.find(current_user).update(stripe_customer_id: @session.customer) if @session.payment_status = "paid"
    #end

    #if @session.payment_status = "unpaid"
    # destroy property ? specific URL immolib redirection view ?
    #end
  end

  def cancel
  end

end

# https://stripe.com/docs/testing
