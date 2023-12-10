class AddPatientIdToPatients < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :patient_id, :string
  end
end
