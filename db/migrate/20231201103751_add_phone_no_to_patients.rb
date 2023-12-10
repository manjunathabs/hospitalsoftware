class AddPhoneNoToPatients < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :phone_no, :string
  end
end
