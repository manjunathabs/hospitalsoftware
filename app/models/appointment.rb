class Appointment < ApplicationRecord
  belongs_to :patient
  belongs_to :timeslot
  validates :appointment_date, presence: true
  has_one :billing, dependent: :destroy
  after_create :create_billing_record

  private

  def create_billing_record

 appointment =   Billing.new(patient: patient, amount: appointment_billing_amount,narration: 'Appointment',status:'Active')
  
 if appointment.save
    puts 'Billing record created successfully!'
  else
    puts 'Error creating billing record:'
    puts appointment.errors.full_messages.join(', ')
  end

  end

  def appointment_billing_amount
    # You can customize this based on your logic for the billing amount for the appointment
    # For example, you might want to set it to a default value or calculate it based on some criteria.
    # Here, I'm assuming a default value of 50.0.
    500.0
  end
end
