module Api
  module V1
    class <%= class_name %>sController < ApiController
      before_action :set_<%= singular_table_name %>, only: [:show, :update, :destroy]
    <%- if options.parent.present? -%>
      before_action :set_<%= singular_parent_table_name %>, only: [:index, :create]
    <%- end -%>
      # collections
      # GET <%= route_url %>
      def index
      <%- if options.parent.present? -%>
        @<%= plural_table_name %> = @<%= singular_parent_table_name %>.<%= plural_table_name %>
      <%- else -%>
        @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
      <%- end -%>
        render json: @<%= plural_table_name %>
      end
      # POST <%= route_url %>
      def create
      <%- if options.parent.present? -%>
        @<%= singular_table_name %> = @<%= singular_parent_table_name %>.<%= plural_table_name %>.build(<%= singular_table_name %>_params)
      <%- else -%>
        @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>
      <%- end -%>

        if @<%= orm_instance.save %>
          render json: @<%= singular_table_name %>, status: :created
        else
          render json: @<%= orm_instance.errors %>, status: :unprocessable_entity
        end
      end
      # members
      # GET <%= route_url %>/1
      def show
        render json: @<%= singular_table_name %>
      end
      # PATCH/PUT <%= route_url %>/1
      def update
        if @<%= orm_instance.update("#{singular_table_name}_params") %>
          render json: @<%= singular_table_name %>
        else
          render json: @<%= orm_instance.errors %>, status: :unprocessable_entity
        end
      end
      # DELETE <%= route_url %>/1
      def destroy
        @<%= orm_instance.destroy %>
      end
      private
        # Use callbacks to share common setup or constraints between actions.
      <%- if options.parent.present? -%>
        def set_<%= singular_parent_table_name %>
          @<%= singular_parent_table_name %> = <%= parent_class %>.find(params[:<%= singular_parent_table_name %>_id].to_i) unless params[:<%= singular_parent_table_name %>_id].nil?
        end
      <%- end -%>
        def set_<%= singular_table_name %>
          @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
        end
        # Only allow a trusted parameter "white list" through.
        def <%= "#{singular_table_name}_params" %>
        <%- if @attributes.empty? -%>
          params.fetch(:<%= singular_table_name %>, {})
        <%- else -%>
          params.require(:<%= singular_table_name %>).permit(<%= attribute_names.map { |attribute| ":#{attribute}" }.join(", ") %>)
        <%- end -%>
        end
    end
  end
end