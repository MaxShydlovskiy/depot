class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :name
      t.text :address
      t.string :email
      t.string :stripe_payment_id
      t.string :status

      t.timestamps
    end
  end
end
