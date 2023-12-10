class Billing < ApplicationRecord
  belongs_to :patient
  validates :narration, presence: true

 # belongs_to :appointment,optional: true
 # validate :appointment_must_exist

 # private

 # def appointment_must_exist
 #   errors.add(:appointment, "must exist") if appointment.present? && !Appointment.exists?(appointment.id)
 # end
end
