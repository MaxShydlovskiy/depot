require 'stripe'

class PaymentIntentsController < ApplicationController
  skip_before_action :authorize, only: [:confirm, :create]
  def create
    Stripe.api_key = Rails.application.credentials.stripe_secret_key

    payment_intent = Stripe::PaymentIntent.create({
      amount: '20000',
      currency: 'usd',
      payment_method_types: [:card],
    })
    render json: {
      id: payment_intent.id,
    }
  end

  def confirm
    confirm_pi = Stripe::PaymentIntent.confirm(

      {payment_method: 'pm_card_visa'},
    )
    render json: confirm_pi
  end
end
