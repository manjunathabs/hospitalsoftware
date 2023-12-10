class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.integer :patient_id
      t.datetime :scheduled_at

      t.timestamps
    end
  end
end
