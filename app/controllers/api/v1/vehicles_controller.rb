module Api
  module V1
    class VehiclesController < ApiController
      before_action :set_vehicle, only: [:show, :update, :destroy]
      before_action :set_license, only: [:index, :create]
      # collections
      # GET /vehicles
      def index
        @vehicles = @license.vehicles
        render json: @vehicles
      end
      # POST /vehicles
      def create
        @vehicle = @license.vehicles.build(vehicle_params)

        if @vehicle.save
          render json: @vehicle, status: :created
        else
          render json: @vehicle.errors, status: :unprocessable_entity
        end
      end
      # members
      # GET /vehicles/1
      def show
        render json: @vehicle
      end
      # PATCH/PUT /vehicles/1
      def update
        if @vehicle.update(vehicle_params)
          render json: @vehicle
        else
          render json: @vehicle.errors, status: :unprocessable_entity
        end
      end
      # DELETE /vehicles/1
      def destroy
        @vehicle.destroy
      end
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_license
          @license = License.find(params[:license_id].to_i) unless params[:license_id].nil?
        end
        def set_vehicle
          @vehicle = Vehicle.find(params[:id])
        end
        # Only allow a trusted parameter "white list" through.
        def vehicle_params
          params.require(:vehicle).permit(:license_id, :vin, :make, :model, :year, :color)
        end
    end
  end
end