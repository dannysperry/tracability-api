module Api
  module V1
    class PatientsController < ApiController
      before_action :set_patient, only: [:show, :update, :destroy]
      before_action :set_physician, only: [:index, :create]
      # collections
      # GET /patients
      def index
        @patients = @physician.patients
        render json: @patients
      end
      # POST /patients
      def create
        @patient = @physician.patients.build(patient_params)

        if @patient.save
          render json: @patient, status: :created
        else
          render json: @patient.errors, status: :unprocessable_entity
        end
      end
      # members
      # GET /patients/1
      def show
        render json: @patient
      end
      # PATCH/PUT /patients/1
      def update
        if @patient.update(patient_params)
          render json: @patient
        else
          render json: @patient.errors, status: :unprocessable_entity
        end
      end
      # DELETE /patients/1
      def destroy
        @patient.destroy
      end
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_physician
          @physician = Physician.find(params[:physician_id].to_i) unless params[:physician_id].nil?
        end
        def set_patient
          @patient = Patient.find(params[:id])
        end
        # Only allow a trusted parameter "white list" through.
        def patient_params
          params.require(:patient).permit(:physician_id, :city_id, :name, :street_address, :is_medical)
        end
    end
  end
end