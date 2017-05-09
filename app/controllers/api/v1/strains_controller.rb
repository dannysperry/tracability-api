module Api
  module V1
    class StrainsController < ApiController
      before_action :set_strain, only: [:show, :update, :destroy]
      # collections
      # GET /strains
      def index
        @strains = Strain.all
        render json: @strains
      end
      # POST /strains
      def create
        @strain = Strain.new(strain_params)

        if @strain.save
          render json: @strain, status: :created
        else
          render json: @strain.errors, status: :unprocessable_entity
        end
      end
      # members
      # GET /strains/1
      def show
        render json: @strain
      end
      # PATCH/PUT /strains/1
      def update
        if @strain.update(strain_params)
          render json: @strain
        else
          render json: @strain.errors, status: :unprocessable_entity
        end
      end
      # DELETE /strains/1
      def destroy
        @strain.destroy
      end
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_strain
          @strain = Strain.find(params[:id])
        end
        # Only allow a trusted parameter "white list" through.
        def strain_params
          params.require(:strain).permit(:name, :expected_potency, :expected_yield, :veg_days, :flower_days)
        end
    end
  end
end