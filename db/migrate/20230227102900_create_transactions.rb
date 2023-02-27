class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.decimal :amount, :precision => 15, :scale => 2
      t.string :currency
      t.string :status, null: false, default: 'charge'
      t.json :details, null: false
    end
  end
end
