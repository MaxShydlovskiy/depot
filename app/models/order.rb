require 'pago'

class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  before_create :set_default_status

  enum :status: [:unpayed, :payed], default: :unpayed

  # has_many :support_requests
  # has_one :support_requests
  validates :name, :address, :email, presence: true
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

end
