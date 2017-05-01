require "rails_helper"

RSpec.describe Api::V1::NotesController do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/v1/notes").to route_to("api/v1/notes#index")
    end

    it "routes to #show" do
      expect(:get => "/v1/notes/1").to route_to("api/v1/notes#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/v1/notes").to route_to("api/v1/notes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/v1/notes/1").to route_to("api/v1/notes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/v1/notes/1").to route_to("api/v1/notes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/v1/notes/1").to route_to("api/v1/notes#destroy", :id => "1")
    end

  end
end