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
          price: Property.find(@property).stripe_price_id,
          quantity: 1
        },
      ],
      mode: 'payment',
      metadata: [@property.to_s],

      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url + '?session_id={CHECKOUT_SESSION_ID}',
    )
    respond_to do |format|
      format.js # renders create.js.erb
    end
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    @property = Property.find(@session.metadata["0"].to_i)

    if @session.payment_status = "paid"
      Property.find(@session.metadata["0"].to_i).update(is_paid: true) 
      #TO UNCOMMENT AFTER ADDING "stripe_customer_id" ATTRIBUTE IN USER MODEL :
      #User.find(current_user).update(stripe_customer_id: @session.customer) if @session.payment_status = "paid"
    end

  end

  def cancel
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @property = Property.find(@session.metadata["0"].to_i)
  end

end

# https://stripe.com/docs/testing
