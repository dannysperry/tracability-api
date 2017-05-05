require "rails_helper"

RSpec.describe Api::V1::<%= controller_class_name %>Controller do
  describe "routing" do
    it "routes to #index" do
    <%- if options.parent.present? -%>
      expect(get: "/v1/<%= plural_parent_table_name %>/1/<%= table_name %>").to route_to("api/v1/<%= table_name %>#index", :<%= singular_parent_table_name %>_id => "1")
    <%- else -%>
      expect(get: "/v1/<%= table_name %>").to route_to("api/v1/<%= table_name %>#index")
    <%- end -%>
    end

    it "routes to #create" do
    <%- if options.parent.present? -%>
      expect(post: "/v1/<%= plural_parent_table_name %>/1/<%= table_name %>").to route_to("api/v1/<%= table_name %>#create", :<%= singular_parent_table_name %>_id => "1")
    <%- else -%>
      expect(post: "/v1/<%= table_name %>").to route_to("api/v1/<%= table_name %>#create")
    <%- end -%>
    end

    it "routes to #show" do
      expect(:get => "/v1/<%= table_name %>/1").to route_to("api/v1/<%= table_name %>#show", :id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/v1/<%= table_name %>/1").to route_to("api/v1/<%= table_name %>#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/v1/<%= table_name %>/1").to route_to("api/v1/<%= table_name %>#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/v1/<%= table_name %>/1").to route_to("api/v1/<%= table_name %>#destroy", :id => "1")
    end

  end
end