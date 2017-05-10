module Api
  module V1
    class RoomSectionsController < ApiController
      before_action :set_room_section, only: [:show, :update, :destroy]
      before_action :set_room, only: [:index, :create]
      # collections
      # GET /room_sections
      def index
        @room_sections = @room.room_sections
        render json: @room_sections
      end
      # POST /room_sections
      def create
        @room_section = @room.room_sections.build(room_section_params)

        if @room_section.save
          render json: @room_section, status: :created
        else
          render json: @room_section.errors, status: :unprocessable_entity
        end
      end
      # members
      # GET /room_sections/1
      def show
        render json: @room_section
      end
      # PATCH/PUT /room_sections/1
      def update
        if @room_section.update(room_section_params)
          render json: @room_section
        else
          render json: @room_section.errors, status: :unprocessable_entity
        end
      end
      # DELETE /room_sections/1
      def destroy
        @room_section.destroy
      end
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_room
          @room = Room.find(params[:room_id].to_i) unless params[:room_id].nil?
        end
        def set_room_section
          @room_section = RoomSection.find(params[:id])
        end
        # Only allow a trusted parameter "white list" through.
        def room_section_params
          params.require(:room_section).permit(:name, :area_in_inches, :section_type, :is_growing_space, :room_id)
        end
    end
  end
end