class AddNarrationToBillings < ActiveRecord::Migration[7.0]
  def change
    add_column :billings, :narration, :string
  end
end
