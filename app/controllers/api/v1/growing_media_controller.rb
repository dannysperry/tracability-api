module Api
  module V1
    class GrowingMediaController < ApiController
      before_action :set_growing_medium, only: [:show, :update, :destroy]
      before_action :set_room_section, only: [:index, :create]
      # collections
      # GET /growing_media
      def index
        @growing_media = @room_section.growing_media
        render json: @growing_media
      end
      # POST /growing_media
      def create
        @growing_medium = @room_section.growing_media.build(growing_medium_params)

        binding.pry

        if @growing_medium.save
          render json: @growing_medium, status: :created
        else
          render json: @growing_medium.errors, status: :unprocessable_entity
        end
      end
      # members
      # GET /growing_media/1
      def show
        render json: @growing_medium
      end
      # PATCH/PUT /growing_media/1
      def update
        if @growing_medium.update(growing_medium_params)
          render json: @growing_medium
        else
          render json: @growing_medium.errors, status: :unprocessable_entity
        end
      end
      # DELETE /growing_media/1
      def destroy
        @growing_medium.destroy
      end
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_room_section
          @room_section = RoomSection.find(params[:room_section_id].to_i) unless params[:room_section_id].nil?
        end
        def set_growing_medium
          @growing_medium = GrowingMedium.find(params[:id])
        end
        # Only allow a trusted parameter "white list" through.
        def growing_medium_params
          params.require(:growing_medium).permit(:room_section_id, :medium_type, :name, :barcode, :quantity, :weight_amount, :weight_amount_type, :weight_type)
        end
    end
  end
end