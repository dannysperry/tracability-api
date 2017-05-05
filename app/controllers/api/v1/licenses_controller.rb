module Api
  module V1
    class LicensesController < ApiController
      before_action :set_license, only: [:show, :update, :destroy]
      before_action :set_state, only: [:index, :create]
      # collections
      # GET /licenses
      def index
        @licenses = @state.licenses
        render json: @licenses
      end
      # POST /licenses
      def create
        @license = @state.licenses.build(license_params)

        if @license.save
          render json: @license, status: :created
        else
          render json: @license.errors, status: :unprocessable_entity
        end
      end
      # members
      # GET /licenses/1
      def show
        render json: @license
      end
      # PATCH/PUT /licenses/1
      def update
        if @license.update(license_params)
          render json: @license
        else
          render json: @license.errors, status: :unprocessable_entity
        end
      end
      # DELETE /licenses/1
      def destroy
        @license.destroy
      end
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_state
          @state = State.find(params[:state_id]) unless params[:state_id].nil?
        end
        def set_license
          @license = License.find(params[:id])
        end
        # Only allow a trusted parameter "white list" through.
        def license_params
          params.require(:license).permit(:license_number, :license_type, :state_id)
        end
    end
  end
end