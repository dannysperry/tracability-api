module Api
  module V1
    class LocationsController < ApiController
      before_action :set_location, only: [:show, :update, :destroy]
      before_action :set_license, only: [:index, :create]
      # collections
      # GET /locations
      def index
        @locations = @license.locations
        render json: @locations
      end
      # POST /locations
      def create
        @location = @license.locations.build(location_params)

        if @location.save
          render json: @location, status: :created
        else
          render json: @location.errors, status: :unprocessable_entity
        end
      end
      # members
      # GET /locations/1
      def show
        render json: @location
      end
      # PATCH/PUT /locations/1
      def update
        if @location.update(location_params)
          render json: @location
        else
          render json: @location.errors, status: :unprocessable_entity
        end
      end
      # DELETE /locations/1
      def destroy
        @location.destroy
      end
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_license
          @license = License.find(params[:license_id].to_i) unless params[:license_id].nil?
        end
        def set_location
          @location = Location.find(params[:id])
        end
        # Only allow a trusted parameter "white list" through.
        def location_params
          params.require(:location).permit(:license_id, :city_id, :name, :street_address, :phone_number, :area_in_inches)
        end
    end
  end
end