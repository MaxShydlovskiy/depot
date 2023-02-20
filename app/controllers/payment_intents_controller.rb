require 'stripe'

class PaymentIntentsController < ApplicationController
  skip_before_action :authorize, only: [:create]
  def create
    Stripe.api_key = Rails.application.credentials.stripe_secret_key

    payment_intent = Stripe::PaymentIntent.create({
      amount: '10000',
      currency: 'usd',
      payment_method_types: [:card],
      payment_method: 'pm_card_visa' || 'pm_card_',
      confirmation_method: 'manual',
      confirm: true,
    })
    render json: payment_intent
  end
end
