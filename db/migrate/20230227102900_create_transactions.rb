class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :charge, default: 'charge'
      t.decimal :amount, :precision => 15, :scale => 2
      t.string :currency
      t.string :status
      t.json :details, null: false
    end
  end
end
