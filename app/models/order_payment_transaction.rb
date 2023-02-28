class OrderPaymentTransaction < ApplicationRecord
  has_one :order
  has_one :payment_transaction
end
