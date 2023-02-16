require 'stripe'

class PaymentIntentsController < ApplicationController
  skip_before_action :authorize, only: [:confirm, :create]
  skip_before_action :verify_authenticity_token, only: [:confirm]
  def create
    Stripe.api_key = Rails.application.credentials.stripe_secret_key

    @payment_intent = Stripe::PaymentIntent.create({
      amount: params[:amount],
      currency: params[:currency],
      payment_method_types: ['card'],
    })
    render json: @payment_intent
  end

  def confirm
    Stripe.api_key = Rails.application.credentials.stripe_secret_key

    confirm = Stripe::PaymentIntent.confirm(
      'pi_3Mc9tXLzcHKkPnpT0eretE0b',
      {payment_method: 'pm_card_visa'},
    )
    confirm

    #   render json: confirm
  end
end
