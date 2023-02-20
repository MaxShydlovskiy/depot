require 'stripe'

class PaymentIntentsController < ApplicationController
  skip_before_action :authorize, only: [:create]
  def create
    Stripe.api_key = Rails.application.credentials.stripe_secret_key

    payment_intent = Stripe::PaymentIntent.create({
      amount: '10000',
      currency: 'usd',
      payment_method_types: [:card],
    })
    render json: payment_intent
  end

  def confirm
    payment_confirm = Stripe::PaymentIntent.confirm

    render json: payment_confirm
  end
end
