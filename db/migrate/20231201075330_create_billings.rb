class CreateBillings < ActiveRecord::Migration[7.0]
  def change
    create_table :billings do |t|
      t.references :patient, null: false, foreign_key: true
      t.references :appointment, null: true, foreign_key: true
      t.decimal :amount

      t.timestamps
    end
  end
end
