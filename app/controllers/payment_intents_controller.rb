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
    payment_confirm = Stripe::PaymentIntent.confirm(
      params[:order_id]
      params[:payment_intent_id]
    {
      "status": "succeeded",
    }
    )

    render json: payment_confirm
  end
end
