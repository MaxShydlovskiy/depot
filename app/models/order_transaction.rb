class OrderTransaction < ApplicationRecord
  has_one :order
  has_many :transactions
end
