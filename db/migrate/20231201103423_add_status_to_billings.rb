class AddStatusToBillings < ActiveRecord::Migration[7.0]
  def change
    add_column :billings, :status, :string
  end
end
