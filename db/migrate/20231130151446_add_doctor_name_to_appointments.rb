class AddDoctorNameToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :doctor_name, :string
  end
end
