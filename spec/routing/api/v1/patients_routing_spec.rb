require "rails_helper"

RSpec.describe Api::V1::PatientsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/physicians/1/patients").to route_to("api/v1/patients#index", :physician_id => "1")
    end

    it "routes to #create" do
      expect(post: "/v1/physicians/1/patients").to route_to("api/v1/patients#create", :physician_id => "1")
    end

    it "routes to #show" do
      expect(:get => "/v1/patients/1").to route_to("api/v1/patients#show", :id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/v1/patients/1").to route_to("api/v1/patients#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/v1/patients/1").to route_to("api/v1/patients#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/v1/patients/1").to route_to("api/v1/patients#destroy", :id => "1")
    end

  end
end