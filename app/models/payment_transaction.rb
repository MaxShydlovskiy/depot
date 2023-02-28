class PaymentTransaction < ApplicationRecord
  belongs_to :order_transaction
end
