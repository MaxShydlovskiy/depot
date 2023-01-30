class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product
  belongs_to :cart, optional: true

  def total_price
    product.price * quantity
  end

  def total_price_in_cents
    (total_price * 100).to_i
  end
end
