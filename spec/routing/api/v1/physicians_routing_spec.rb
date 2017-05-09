require "rails_helper"

RSpec.describe Api::V1::PhysiciansController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/physicians").to route_to("api/v1/physicians#index")
    end

    it "routes to #create" do
      expect(post: "/v1/physicians").to route_to("api/v1/physicians#create")
    end

    it "routes to #show" do
      expect(:get => "/v1/physicians/1").to route_to("api/v1/physicians#show", :id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/v1/physicians/1").to route_to("api/v1/physicians#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/v1/physicians/1").to route_to("api/v1/physicians#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/v1/physicians/1").to route_to("api/v1/physicians#destroy", :id => "1")
    end

  end
end