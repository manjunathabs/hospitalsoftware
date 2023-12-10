class PatientsController < ApplicationController
  def new
    @patient = Patient.new
  end
 

  def index
    @patients = Patient.all

     

@from_date = params[:from_date]
    @to_date = params[:to_date]

    if @from_date.present? && @to_date.present?
	    @patients = Patient.where(date_of_birth: @from_date..@to_date).paginate(page: params[:page], per_page: 5)
      
      @registrations_data = Patient.registrations_per_day(@from_date, @to_date)
    else
	    @patients = Patient.all.paginate(page: params[:page], per_page: 5)
      @registrations_data = Patient.registrations_per_day(nil, nil)
    end



 
    #    @registrations_data = Patient.registrations_per_day

    respond_to do |format|
      format.html
      format.pdf do
     #   render pdf: 'patients_report', layout: 'layouts/pdf.html.erb'
#	render pdf: 'patients_report', layout: 'pdf.html.erb'
	      render pdf: 'patients_report', layout: 'pdf'

      end

      format.xlsx {
       # response.headers['Content-Disposition'] = 'attachment; filename=patients_report.xlsx'
	            #  render xlsx: 'index', filename: 'patients_report.xlsx'
	      
	      render xlsx: "index", filename: 'patients_report.xlsx'


      }
    end
  end
  def show
	      @patient = Patient.find(params[:id])
	          flash.now[:notice] = 'Patient details loaded successfully.'


  end



def filter_by_date
    from_date = params[:from_date]
    to_date = params[:to_date]

    # Add logic to filter patients based on date range
     
    @patients = Patient.filter_by_date_range(from_date, to_date)

    respond_to do |format|
      format.js # render filter_by_date.js.erb
    end
  end









  def create
    @patient = Patient.new(patient_params)
     
    if @patient.save 
      redirect_to patient_path(@patient), notice: 'Patient registered successfully!'
    else
      render :new
    end
  end

  private

  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :date_of_birth, :email,:phone_no)
  end


end
