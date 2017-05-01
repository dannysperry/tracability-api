require "rails_helper"

RSpec.describe Api::V1::InventoryTypesController do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/v1/inventory_types").to route_to("api/v1/inventory_types#index")
    end

    it "routes to #show" do
      expect(:get => "/v1/inventory_types/1").to route_to("api/v1/inventory_types#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/v1/inventory_types").to route_to("api/v1/inventory_types#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/v1/inventory_types/1").to route_to("api/v1/inventory_types#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/v1/inventory_types/1").to route_to("api/v1/inventory_types#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/v1/inventory_types/1").to route_to("api/v1/inventory_types#destroy", :id => "1")
    end

  end
end