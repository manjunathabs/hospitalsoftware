class AddAppointmentDateToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :appointment_date, :date
  end
end
