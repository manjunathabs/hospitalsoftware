class RemoveAppointmentIdFromBillings < ActiveRecord::Migration[7.0]
  def change
    remove_column :billings, :appointment_id, :integer
  end
end
