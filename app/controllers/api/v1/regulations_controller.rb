module Api
  module V1
    class RegulationsController < ApiController
      before_action :set_regulation, only: [:show, :update, :destroy]
      # collections
      # GET /regulations
      def index
        @regulations = Regulation.all
        render json: @regulations
      end
      # POST /regulations
      def create
        @regulation = Regulation.new(regulation_params)

        if @regulation.save
          render json: @regulation, status: :created
        else
          render json: @regulation.errors, status: :unprocessable_entity
        end
      end
      # members
      # GET /regulations/1
      def show
        render json: @regulation
      end
      # PATCH/PUT /regulations/1
      def update
        if @regulation.update(regulation_params)
          render json: @regulation
        else
          render json: @regulation.errors, status: :unprocessable_entity
        end
      end
      # DELETE /regulations/1
      def destroy
        @regulation.destroy
      end
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_regulation
          @regulation = Regulation.find(params[:id])
        end
        # Only allow a trusted parameter "white list" through.
        def regulation_params
          params.require(:regulation).permit(:legal_reference_code)
        end
    end
  end
end