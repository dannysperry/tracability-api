require "rails_helper"

RSpec.describe Api::V1::CitiesController do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/v1/states/1/cities").to route_to("api/v1/cities#index", state_id: "1")
    end

    it "routes to #create" do
      expect(:post => "/v1/states/1/cities").to route_to("api/v1/cities#create", state_id: "1")
    end

    it "routes to #show" do
      expect(:get => "/v1/cities/1").to route_to("api/v1/cities#show", :id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/v1/cities/1").to route_to("api/v1/cities#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/v1/cities/1").to route_to("api/v1/cities#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/v1/cities/1").to route_to("api/v1/cities#destroy", :id => "1")
    end

  end
end