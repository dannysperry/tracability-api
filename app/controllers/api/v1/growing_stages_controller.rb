module Api
  module V1
    class GrowingStagesController < ApiController
      before_action :set_growing_stage, only: [:show, :update, :destroy]
      before_action :set_license, only: [:index, :create]
      # collections
      # GET /growing_stages
      def index
        @growing_stages = @license.growing_stages
        render json: @growing_stages
      end
      # POST /growing_stages
      def create
        @growing_stage = @license.growing_stages.build(growing_stage_params)

        if @growing_stage.save
          render json: @growing_stage, status: :created
        else
          render json: @growing_stage.errors, status: :unprocessable_entity
        end
      end
      # members
      # GET /growing_stages/1
      def show
        render json: @growing_stage
      end
      # PATCH/PUT /growing_stages/1
      def update
        if @growing_stage.update(growing_stage_params)
          render json: @growing_stage
        else
          render json: @growing_stage.errors, status: :unprocessable_entity
        end
      end
      # DELETE /growing_stages/1
      def destroy
        @growing_stage.destroy
      end
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_license
          @license = License.find(params[:license_id].to_i) unless params[:license_id].nil?
        end
        def set_growing_stage
          @growing_stage = GrowingStage.find(params[:id])
        end
        # Only allow a trusted parameter "white list" through.
        def growing_stage_params
          params.require(:growing_stage).permit(:name, :description, :license_id)
        end
    end
  end
end