require "rails_helper"

RSpec.describe DinosaursController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/dinosaurs").to route_to("dinosaurs#index", format: :json)
    end

    it "routes to #show" do
      expect(get: "/dinosaurs/1").to route_to("dinosaurs#show", id: "1", format: :json)
    end


    it "routes to #create" do
      expect(post: "/dinosaurs").to route_to("dinosaurs#create", format: :json)
    end

    it "routes to #update via PUT" do
      expect(put: "/dinosaurs/1").to route_to("dinosaurs#update", id: "1", format: :json)
    end

    it "routes to #update via PATCH" do
      expect(patch: "/dinosaurs/1").to route_to("dinosaurs#update", id: "1", format: :json)
    end

    it "routes to #destroy" do
      expect(delete: "/dinosaurs/1").to route_to("dinosaurs#destroy", id: "1", format: :json)
    end
  end
end
