module Api
  module V1
    class PhysiciansController < ApiController
      before_action :set_physician, only: [:show, :update, :destroy]
      # collections
      # GET /physicians
      def index
        @physicians = Physician.all
        render json: @physicians
      end
      # POST /physicians
      def create
        @physician = Physician.new(physician_params)

        if @physician.save
          render json: @physician, status: :created
        else
          render json: @physician.errors, status: :unprocessable_entity
        end
      end
      # members
      # GET /physicians/1
      def show
        render json: @physician
      end
      # PATCH/PUT /physicians/1
      def update
        if @physician.update(physician_params)
          render json: @physician
        else
          render json: @physician.errors, status: :unprocessable_entity
        end
      end
      # DELETE /physicians/1
      def destroy
        @physician.destroy
      end
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_physician
          @physician = Physician.find(params[:id])
        end
        # Only allow a trusted parameter "white list" through.
        def physician_params
          params.require(:physician).permit(:name, :license_number)
        end
    end
  end
end