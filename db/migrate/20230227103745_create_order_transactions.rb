class CreateOrderTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :order_transactions do |t|

      t.timestamps
    end
  end
end
