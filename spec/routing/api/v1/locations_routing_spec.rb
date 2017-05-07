require "rails_helper"

RSpec.describe Api::V1::LocationsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/licenses/1/locations").to route_to("api/v1/locations#index", :license_id => "1")
    end

    it "routes to #create" do
      expect(post: "/v1/licenses/1/locations").to route_to("api/v1/locations#create", :license_id => "1")
    end

    it "routes to #show" do
      expect(:get => "/v1/locations/1").to route_to("api/v1/locations#show", :id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/v1/locations/1").to route_to("api/v1/locations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/v1/locations/1").to route_to("api/v1/locations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/v1/locations/1").to route_to("api/v1/locations#destroy", :id => "1")
    end

  end
end