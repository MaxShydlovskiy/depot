require 'stripe'

class PaymentIntentsController < ApplicationController
  skip_before_action :authorize, only: [:create, :confirm]
  skip_before_action :verify_authenticity_token, only: [ :confirm ]
  def create
    Stripe.api_key = Rails.application.credentials.stripe_secret_key

    payment_intent = Stripe::PaymentIntent.create({
      amount: params[:amount],
      currency: 'usd',
      payment_method: params[:payment_method_id]
    })
    render json: payment_intent
  end

  def confirm
    Stripe.api_key = Rails.application.credentials.stripe_secret_key
    order = Order.find(params[:order_id])

    payment_confirm = Stripe::PaymentIntent.confirm(
      params[:payment_intent_id]
    )
    charge = Stripe::Charge.retrieve(payment_confirm[:latest_charge])

    payment_transaction = PaymentTransaction.create(
      amount:   payment_confirm[:amount],
      currency: payment_confirm[:currency],
      status:   payment_confirm[:status],
      details:  charge
    )

    OrderPaymentTransaction.find_or_create_by(
      order_id:               params[:order_id],
      payment_transaction_id: payment_transaction.id
    )



    if payment_confirm[:status] == 'succeeded'
      order.update(status: 'payed')
    end

    render json: payment_confirm

  end
end
