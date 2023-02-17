require 'stripe'

class PaymentIntentsController < ApplicationController
  skip_before_action :authorize, only: [:confirm, :create]
  def create
    Stripe.api_key = Rails.application.credentials.stripe_secret_key

    payment_intent = Stripe::PaymentIntent.create({
      amount: '20000',
      currency: 'usd',
    })
    render json: {
      id: payment_intent.id,
      client_secret: payment_intent.client_secret
    }
  end
end
