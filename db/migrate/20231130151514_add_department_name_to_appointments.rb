class AddDepartmentNameToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :department_name, :string
  end
end
