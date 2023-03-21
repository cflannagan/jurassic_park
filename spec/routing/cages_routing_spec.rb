require "rails_helper"

RSpec.describe CagesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/cages").to route_to("cages#index", format: :json)
    end

    it "routes to #show" do
      expect(get: "/cages/1").to route_to("cages#show", id: "1", format: :json)
    end

    it "routes to #create" do
      expect(post: "/cages").to route_to("cages#create", format: :json)
    end

    it "routes to #update via PUT" do
      expect(put: "/cages/1").to route_to("cages#update", id: "1", format: :json)
    end

    it "routes to #update via PATCH" do
      expect(patch: "/cages/1").to route_to("cages#update", id: "1", format: :json)
    end

    it "routes to #destroy" do
      expect(delete: "/cages/1").to route_to("cages#destroy", id: "1", format: :json)
    end
  end
end
