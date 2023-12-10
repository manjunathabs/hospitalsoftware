class Timeslot < ApplicationRecord
	  has_many :appointments
  def display_time
    "#{start_time.strftime('%I:%M %p')} - #{end_time.strftime('%I:%M %p')}"
  end



  def self.available_for_date(date)
    taken_timeslot_ids = Appointment.where(appointment_date: date).pluck(:timeslot_id)
    where.not(id: taken_timeslot_ids)
  end
end
