require "rails_helper"

RSpec.describe SpeciesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/species").to route_to("species#index", format: :json)
    end

    it "routes to #show" do
      expect(get: "/species/1").to route_to("species#show", id: "1", format: :json)
    end


    it "routes to #create" do
      expect(post: "/species").to route_to("species#create", format: :json)
    end

    it "routes to #update via PUT" do
      expect(put: "/species/1").to route_to("species#update", id: "1", format: :json)
    end

    it "routes to #update via PATCH" do
      expect(patch: "/species/1").to route_to("species#update", id: "1", format: :json)
    end

    it "routes to #destroy" do
      expect(delete: "/species/1").to route_to("species#destroy", id: "1", format: :json)
    end
  end
end
