require "rails_helper"

RSpec.describe Api::V1::StatesController do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/v1/states").to route_to("api/v1/states#index")
    end

    it "routes to #show" do
      expect(:get => "/v1/states/1").to route_to("api/v1/states#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/v1/states").to route_to("api/v1/states#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/v1/states/1").to route_to("api/v1/states#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/v1/states/1").to route_to("api/v1/states#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/v1/states/1").to route_to("api/v1/states#destroy", :id => "1")
    end

  end
end