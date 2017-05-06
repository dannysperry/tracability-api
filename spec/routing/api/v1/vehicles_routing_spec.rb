require "rails_helper"

RSpec.describe Api::V1::VehiclesController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/licenses/1/vehicles").to route_to("api/v1/vehicles#index", :license_id => "1")
    end

    it "routes to #create" do
      expect(post: "/v1/licenses/1/vehicles").to route_to("api/v1/vehicles#create", :license_id => "1")
    end

    it "routes to #show" do
      expect(:get => "/v1/vehicles/1").to route_to("api/v1/vehicles#show", :id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/v1/vehicles/1").to route_to("api/v1/vehicles#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/v1/vehicles/1").to route_to("api/v1/vehicles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/v1/vehicles/1").to route_to("api/v1/vehicles#destroy", :id => "1")
    end

  end
end