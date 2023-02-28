class CreateOrderTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :order_transactions do |t|
      t.integer :order_id
      t.integer :transaction_id

      t.timestamps
    end
  end
end
