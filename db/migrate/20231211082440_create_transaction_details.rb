class CreateTransactionDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :transaction_details do |t|
      t.string :receipt_number
      t.string :narration
      t.decimal :amount
      t.references :patient, null: false, foreign_key: true
      t.references :billing, null: false, foreign_key: true

      t.timestamps
    end
  end
end
