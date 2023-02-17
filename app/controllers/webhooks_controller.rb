class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil
    endpoint_secret = Rails.application.credentials.stripe[:webhook_secret]

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError => e
      # Invalid payload
      render json: { message: 'invalid json' }, status: 400
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      render json: { message: 'signature verification failed' }, status: 400
      return
    end

    # Handle the event
    case event.type
    when 'payment_intent.succeeded'
      payment_intent = event.data.object # contains a Stripe::PaymentIntent

      puts "PaymentIntent succeeded"
      @order = Order.find_by!(stripe_payment_id: payment_intent.id)
      @order.update(status: 'paid')
      puts "Order found: #{@order.title}"

      # OrderMailer.receipt(@order).deliver_later
      # OrderMailer.neworder(@order).deliver_later
    else
      puts "Unhandled event type: #{event.type}"
    end

    render json: { message: 'success' }
  end
end
