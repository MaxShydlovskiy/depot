class OrderTransaction < ApplicationRecord
  has_many :order
  has_one :payment_transaction
end
