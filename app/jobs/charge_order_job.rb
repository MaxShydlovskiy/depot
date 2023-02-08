class ChargeOrderJob < ApplicationJob
  queue_as :default

  def perform(order)
    order.charge!

    # Do something later
  end
end
