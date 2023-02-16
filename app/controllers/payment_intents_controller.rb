require 'stripe'

class PaymentIntentsController < ApplicationController
  def create
    Stripe.api_key = Rails.application.credentials.stripe_secret_key

    payment_intent = Stripe::PaymentIntent.create({
      amount: params[:amount],
      currency: params[:currency],
      payment_method_types: ['card'],
    })
    payment_intent
  end
end
