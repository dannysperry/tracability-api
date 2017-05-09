require "rails_helper"

RSpec.describe Api::V1::StrainsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/v1/strains").to route_to("api/v1/strains#index")
    end

    it "routes to #create" do
      expect(post: "/v1/strains").to route_to("api/v1/strains#create")
    end

    it "routes to #show" do
      expect(:get => "/v1/strains/1").to route_to("api/v1/strains#show", :id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/v1/strains/1").to route_to("api/v1/strains#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/v1/strains/1").to route_to("api/v1/strains#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/v1/strains/1").to route_to("api/v1/strains#destroy", :id => "1")
    end

  end
end