#class AppointmentsController < ApplicationController
#end




# app/controllers/appointments_controller.rb
class AppointmentsController < ApplicationController
  before_action :load_patients, only: :index
#  before_action :set_patient, except: [:index, :new, :create]
   before_action :set_patient, only: [:new, :create]

  before_action :load_timeslots, only: [:new, :create]
  before_action :load_dates, only: [:new, :create]

  def index
#    @appointments = @patient.appointments if @patient
	  @appointments = @patient ? @patient.appointments.paginate(page: params[:page], per_page: 5) : Appointment.all.paginate(page: params[:page], per_page: 5)
#@appointments = Appointment.paginate(page: params[:page], per_page: 5)
    @patients = Patient.paginate(page: params[:page], per_page: 5)
  end

  def new
 #   @appointment = Appointment.new
    @patient = Patient.find(params[:patient_id])
  @appointment = @patient.appointments.new
  end

  def create
	    
    @appointment = @patient.appointments.new(appointment_params)
     
    if @appointment.save
	    
     # redirect_to patient_appointments_path(@patient), notice: 'Appointment was successfully scheduled.'
	  redirect_to appointments_path, notice: 'Appointment was successfully scheduled.'
	    
    else
      render :new
    end
  end

def available_timeslots
    selected_date = params[:selected_date]
    @timeslots = Timeslot.available_for_date(selected_date)

    respond_to do |format|
      format.json { render json: @timeslots }
    end
  end





  private
  def load_patients
    @patients = Patient.all
  end

  def set_patient 
    @patient = Patient.find(params[:patient_id]) if params[:patient_id].present?
  end

 def load_timeslots
    @timeslots = Timeslot.all
  end

   def load_dates
    # You can customize this based on your specific requirements
    @dates = (Date.today..(Date.today + 7.days)).to_a
  end
  
  def appointment_params
#    params.require(:appointment).permit(:scheduled_at)
 #   params.require(:appointment).permit(:doctor_name, :department_name, :other_fields)
    params.require(:appointment).permit(:doctor_name, :department_name, :timeslot_id, :appointment_date)

  end
end
























