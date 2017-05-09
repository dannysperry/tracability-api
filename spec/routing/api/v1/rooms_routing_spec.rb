require "rails_helper"

RSpec.describe Api::V1::RoomsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/locations/1/rooms").to route_to("api/v1/rooms#index", :location_id => "1")
    end

    it "routes to #create" do
      expect(post: "/v1/locations/1/rooms").to route_to("api/v1/rooms#create", :location_id => "1")
    end

    it "routes to #show" do
      expect(:get => "/v1/rooms/1").to route_to("api/v1/rooms#show", :id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/v1/rooms/1").to route_to("api/v1/rooms#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/v1/rooms/1").to route_to("api/v1/rooms#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/v1/rooms/1").to route_to("api/v1/rooms#destroy", :id => "1")
    end

  end
end