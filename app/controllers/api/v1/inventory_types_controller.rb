module Api
  module V1
    class InventoryTypesController < ApiController
      before_action :set_inventory_type, only: [:show, :update, :destroy]
      # GET /inventory_types
      def index
        @inventory_types = InventoryType.all
        render json: @inventory_types
      end
      # GET /inventory_types/1
      def show
        render json: @inventory_type
      end
      # POST /inventory_types
      def create
        @inventory_type = InventoryType.new(inventory_type_params)

        if @inventory_type.save
          render json: @inventory_type, status: :created, location: ['v1', @inventory_type]
        else
          render json: @inventory_type.errors, status: :unprocessable_entity
        end
      end
      # PATCH/PUT /inventory_types/1
      def update
        if @inventory_type.update(inventory_type_params)
          render json: @inventory_type
        else
          render json: @inventory_type.errors, status: :unprocessable_entity
        end
      end
      # DELETE /inventory_types/1
      def destroy
        @inventory_type.destroy
      end
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_inventory_type
          @inventory_type = InventoryType.find(params[:id])
        end
        # Only allow a trusted parameter "white list" through.
        def inventory_type_params
          params.require(:inventory_type).permit(:name)
        end
    end
  end
end