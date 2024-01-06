class BillingsController < ApplicationController
  before_action :set_billing, only: [:edit, :update, :destroy]

  def index
   # @billings = Billing.all
#    @patient = Patient.find(params[:patient_id])
#    @billings = @patient.billings
  end

  def show
  end

def search
    patient_id = params[:patient_id]
    @patient = Patient.find_by(patient_id: patient_id)
    
    if @patient
	    @billings = @patient.billing.where(status: 'Active')
  #    redirect_to billings_path(@billings)
    else
      flash[:alert] = "Patient with ID #{patient_id} not found."
     # redirect_to billings_path
    end
    render :index
  end



  def make_payment
	  @patient = Patient.find(params[:format])
	   
    billing_ids = params[:billing_ids]

    if billing_ids.present?
      Billing.where(id: billing_ids).update_all(status: 'paid')

      billing_ids.each do |billing_id|
        billing = Billing.find(billing_id)
        @patient.make_payment_rec(billing.amount, billing)
      end
     # generate_billing_slips(billing_ids)
     redirect_to show_receipt_path(@patient), notice: 'Payments successful.'
    else
      flash[:alert] = 'No bills selected for payment.'
      render :index
    end
  end



def show_receipt
          @patient = Patient.find(params[:format])

   # @paid_bills = @patient.billing.paid
	      @paid_bills = @patient.billing.where(status: 'paid')

#    respond_to do |format|
#      format.html
#    end
  end



  def new
    @billing = Billing.new
  end

  def create
	  raise billing_params.inspect 
    @billing = Billing.new(billing_params)
    if @billing.save
      redirect_to @billing, notice: 'Billing record was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @billing.update(billing_params)
      redirect_to @billing, notice: 'Billing record was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @billing.destroy
    redirect_to billings_url, notice: 'Billing record was successfully destroyed.'
  end

  private

  def set_billing
    @billing = Billing.find(params[:id])
  end

  def billing_params
    params.require(:billing).permit(:patient_id, :appointment_id, :amount)
  end
end

