require "rails_helper"

RSpec.describe Api::V1::GrowingMediaController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/room_sections/1/growing_media").to route_to("api/v1/growing_media#index", :room_section_id => "1")
    end

    it "routes to #create" do
      expect(post: "/v1/room_sections/1/growing_media").to route_to("api/v1/growing_media#create", :room_section_id => "1")
    end

    it "routes to #show" do
      expect(:get => "/v1/growing_media/1").to route_to("api/v1/growing_media#show", :id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/v1/growing_media/1").to route_to("api/v1/growing_media#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/v1/growing_media/1").to route_to("api/v1/growing_media#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/v1/growing_media/1").to route_to("api/v1/growing_media#destroy", :id => "1")
    end

  end
end