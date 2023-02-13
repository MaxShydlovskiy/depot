class ChargeOrderJob < ApplicationJob
  queue_as :default

  def perform(order, order_params)
    order.charge!(order_params)

    # Do something later
  end
end
