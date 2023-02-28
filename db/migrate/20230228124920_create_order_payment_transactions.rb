class CreateOrderPaymentTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :order_payment_transactions do |t|
      t.integer :order_id
      t.integer :payment_transaction_id

      t.timestamps
    end
  end
end
