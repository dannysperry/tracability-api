module Api
  module V1
    class CitiesController < ApiController
      before_action :set_city, only: [:show, :update, :destroy]
      before_action :set_state, only: [:index, :create]
      # collections
      # GET /cities
      def index
        @cities = @state.cities
        render json: @cities
      end
      # POST /cities
      def create
        @city = @state.cities.build city_params

        if @city.save
          render json: @city, status: :created
        else
          render json: @city.errors, status: :unprocessable_entity
        end
      end
      # members
      # GET /cities/1
      def show
        render json: @city
      end
      # PATCH/PUT /cities/1
      def update
        if @city.update(city_params)
          render json: @city
        else
          render json: @city.errors, status: :unprocessable_entity
        end
      end
      # DELETE /cities/1
      def destroy
        @city.destroy
      end
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_state
          unless params[:state_id].nil?
            @state = State.find(params[:state_id].to_i)
          end
        end
        def set_city
          @city = City.find(params[:id])
        end
        # Only allow a trusted parameter "white list" through.
        def city_params
          params.require(:city).permit(:state_id, :name)
        end
    end
  end
end