require "rails_helper"

RSpec.describe Api::V1::LicensesController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/states/1/licenses").to route_to("api/v1/licenses#index", :state_id => "1")
    end

    it "routes to #create" do
      expect(post: "/v1/states/1/licenses").to route_to("api/v1/licenses#create", :state_id => "1")
    end

    it "routes to #show" do
      expect(:get => "/v1/licenses/1").to route_to("api/v1/licenses#show", :id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/v1/licenses/1").to route_to("api/v1/licenses#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/v1/licenses/1").to route_to("api/v1/licenses#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/v1/licenses/1").to route_to("api/v1/licenses#destroy", :id => "1")
    end

  end
end