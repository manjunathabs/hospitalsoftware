require 'numbers_and_words'

class Patient < ApplicationRecord
  before_create :generate_patient_id
    has_many :appointments
    has_many :billing, dependent: :destroy
    has_many :transaction_details	  
 validates :first_name, :last_name, :date_of_birth, :email, presence: true
 after_create :create_initial_billing_record

 # scope :registrations_per_day, -> { group("DATE(created_at)").order("DATE(created_at)").count }
scope :registrations_per_day, ->(start_date, end_date) {
    where(created_at: start_date..end_date)
      .group("DATE(created_at)")
      .order("DATE(created_at)")
      .count
  }



  def make_payment_rec(amount,billing)
    #billing = billings.create(narration: 'Payment', amount: amount)

    # Generate a unique receipt number
    receipt_number = generate_receipt_number

    # Create a new transaction detail
    transaction_details.create(
      receipt_number: receipt_number,
      narration: 'Payment',
      amount: amount,
      billing: billing
    )
  end

def registration_amount
    reg_billing = billing.find_by(narration: 'REG')

    return 0 unless reg_billing # Return 0 if there's no billing record with 'REG'

    reg_billing.amount
  end
def registration_amount_in_words
	reg_amount = billing.find_by(narration: 'REG').amount
	 
    # Convert the registration amount into words
	I18n.with_locale(:en) { reg_amount.to_f.to_words }
  end




def self.filter_by_date_range(from_date, to_date)
    if from_date.present? && to_date.present?
      where(created_at: from_date.to_date.beginning_of_day..to_date.to_date.end_of_day)
    elsif from_date.present?
      where('created_at >= ?', from_date.to_date.beginning_of_day)
    elsif to_date.present?
      where('created_at <= ?', to_date.to_date.end_of_day)
    else
      all
    end
  end






 private
  
  def generate_receipt_number
  current_year = Time.now.year
  last_receipt = TransactionDetail.where("receipt_number LIKE ?", "REC/#{current_year}/%").order(:created_at).last

  if last_receipt
    last_counter = last_receipt.receipt_number.split('/').last.to_i
    new_counter = last_counter + 1
  else
    new_counter = 00001
  end

  "REC/#{current_year}/#{new_counter.to_s.rjust(5, '0')}"
end


  def generate_patient_id
    # Find the highest existing patient_id and increment it
   # highest_id = Patient.maximum(:patient_id)
    
   # self.patient_id = highest_id ? (highest_id + 1).to_s.rjust(5, '0') : '00001'
	  highest_id = Patient.maximum(:patient_id)
    
   # new_id = highest_id ? (highest_id + 1).to_s.rjust(5, '0') : '00001'
#      new_id = highest_id ? (highest_id + 1).to_s.rjust(5, '0') : '00001'
    counter = highest_id ? highest_id.scan(/\d+/).first.to_i + 1 : 1
    new_id = counter.to_s.rjust(5, '0')


    self.patient_id = "PAT#{new_id}"
  end
  

  def create_initial_billing_record
	   
#	  Billing.create(patient_id: self.id, amount: initial_billing_amount)

	 billing = Billing.new(patient: self, amount: initial_billing_amount,narration: 'REG',status:'Active')
	  
  if billing.save
    puts 'Billing record created successfully!'
  else
    puts 'Error creating billing record:'
    puts billing.errors.full_messages.join(', ')
  end
  end

  def initial_billing_amount
    # You can customize this based on your logic for the initial billing amount
    # For example, you might want to set it to a default value or calculate it based on some criteria.
    # Here, I'm assuming a default value of 0.0.
    100.0
  end


end
