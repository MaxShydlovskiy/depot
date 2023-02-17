class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil
    endpoint_secret = 'whsec_42a92269b875523d526827deab58e0ad5de19ea4b5d3933553d11dd092c556ab'

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError => e
      # Invalid payload
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      status 400
      return
    end

    # Handle the event
    case event.type
    when 'payment_intent.succeeded'
      puts "PaymentIntent suceeded"
      @order = Order.find_by!(stripe_payment_id: payment_intent.id)
      puts "Order found #{order.name}"
    when 'payment_method.attached'
      payment_method = event.data.object # contains a Stripe::PaymentMethod
      puts 'PaymentMethod was attached to a Order!'
    # ... handle other event types
    else
      puts "Unhandled event type: #{event.type}"
    end

    status 200
  end
end
