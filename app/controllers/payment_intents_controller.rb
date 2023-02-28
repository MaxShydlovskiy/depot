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
    # @order = Order.find(params[:order_id])
    # { error: { message: "Order not found" }, status: 404 }

    OrderTransaction.find_or_create_by(params[:order_id])


    payment_confirm = Stripe::PaymentIntent.confirm(
      params[:payment_intent_id]
    )

    render json: payment_confirm



    if payment_confirm[:status] == 'succeeded'
      Order.find(params[:order_id]).update(status: 'payed')
    end

    # render json: payment_confirm

    # Transaction.update(details: charges["data"].first)
  end
end
