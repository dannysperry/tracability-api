module Api
  module V1
    class RoomsController < ApiController
      before_action :set_room, only: [:show, :update, :destroy]
      before_action :set_location, only: [:index, :create]
      # collections
      # GET /rooms
      def index
        @rooms = @location.rooms
        render json: @rooms
      end
      # POST /rooms
      def create
        @room = @location.rooms.build(room_params)

        if @room.save
          render json: @room, status: :created
        else
          render json: @room.errors, status: :unprocessable_entity
        end
      end
      # members
      # GET /rooms/1
      def show
        render json: @room
      end
      # PATCH/PUT /rooms/1
      def update
        if @room.update(room_params)
          render json: @room
        else
          render json: @room.errors, status: :unprocessable_entity
        end
      end
      # DELETE /rooms/1
      def destroy
        @room.destroy
      end
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_location
          @location = Location.find(params[:location_id].to_i) unless params[:location_id].nil?
        end
        def set_room
          @room = Room.find(params[:id])
        end
        # Only allow a trusted parameter "white list" through.
        def room_params
          params.require(:room).permit(:room_type, :location_id, :name, :area_in_inches, :is_growing_space)
        end
    end
  end
end