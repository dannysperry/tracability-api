require "rails_helper"

RSpec.describe Api::V1::GrowingStagesController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/licenses/1/growing_stages").to route_to("api/v1/growing_stages#index", :license_id => "1")
    end

    it "routes to #create" do
      expect(post: "/v1/licenses/1/growing_stages").to route_to("api/v1/growing_stages#create", :license_id => "1")
    end

    it "routes to #show" do
      expect(:get => "/v1/growing_stages/1").to route_to("api/v1/growing_stages#show", :id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/v1/growing_stages/1").to route_to("api/v1/growing_stages#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/v1/growing_stages/1").to route_to("api/v1/growing_stages#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/v1/growing_stages/1").to route_to("api/v1/growing_stages#destroy", :id => "1")
    end

  end
end