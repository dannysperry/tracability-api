require "rails_helper"

RSpec.describe Api::V1::RegulationsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/regulations").to route_to("api/v1/regulations#index")
    end

    it "routes to #create" do
      expect(post: "/v1/regulations").to route_to("api/v1/regulations#create")
    end

    it "routes to #show" do
      expect(:get => "/v1/regulations/1").to route_to("api/v1/regulations#show", :id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/v1/regulations/1").to route_to("api/v1/regulations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/v1/regulations/1").to route_to("api/v1/regulations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/v1/regulations/1").to route_to("api/v1/regulations#destroy", :id => "1")
    end

  end
end