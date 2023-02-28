class OrderTransaction < ApplicationRecord
  has_one :order
  has_one :transaction
end
