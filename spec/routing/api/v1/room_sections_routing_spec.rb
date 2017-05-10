require "rails_helper"

RSpec.describe Api::V1::RoomSectionsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/rooms/1/room_sections").to route_to("api/v1/room_sections#index", :room_id => "1")
    end

    it "routes to #create" do
      expect(post: "/v1/rooms/1/room_sections").to route_to("api/v1/room_sections#create", :room_id => "1")
    end

    it "routes to #show" do
      expect(:get => "/v1/room_sections/1").to route_to("api/v1/room_sections#show", :id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/v1/room_sections/1").to route_to("api/v1/room_sections#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/v1/room_sections/1").to route_to("api/v1/room_sections#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/v1/room_sections/1").to route_to("api/v1/room_sections#destroy", :id => "1")
    end

  end
end