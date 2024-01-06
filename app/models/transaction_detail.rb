class TransactionDetail < ApplicationRecord
  belongs_to :patient
  belongs_to :billing
end
