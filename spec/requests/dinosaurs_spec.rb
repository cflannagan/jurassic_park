require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/dinosaurs", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Dinosaur. As you add validations to Dinosaur, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { name: "Ty", species_id: create(:species).id }
  }

  let(:invalid_attributes) {
    { name: nil, species_id: nil }
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # DinosaursController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Dinosaur.create! valid_attributes
      get dinosaurs_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      dinosaur = Dinosaur.create! valid_attributes
      get dinosaur_url(dinosaur), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Dinosaur" do
        expect {
          post dinosaurs_url,
               params: { dinosaur: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Dinosaur, :count).by(1)
      end

      it "renders a JSON response with the new dinosaur" do
        post dinosaurs_url,
             params: { dinosaur: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Dinosaur" do
        expect {
          post dinosaurs_url,
               params: { dinosaur: invalid_attributes }, as: :json
        }.to change(Dinosaur, :count).by(0)
      end

      it "renders a JSON response with errors for the new dinosaur" do
        post dinosaurs_url,
             params: { dinosaur: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:cage) { create(:cage, :active) }
      let(:new_attributes) {
        { cage_id: cage.id }
      }

      it "updates the requested dinosaur" do
        dinosaur = Dinosaur.create! valid_attributes
        patch dinosaur_url(dinosaur),
              params: { dinosaur: new_attributes }, headers: valid_headers, as: :json
        dinosaur.reload
        expect(dinosaur.cage).to eq cage
      end

      it "renders a JSON response with the dinosaur" do
        dinosaur = Dinosaur.create! valid_attributes
        patch dinosaur_url(dinosaur),
              params: { dinosaur: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the dinosaur" do
        dinosaur = Dinosaur.create! valid_attributes
        patch dinosaur_url(dinosaur),
              params: { dinosaur: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested dinosaur" do
      dinosaur = Dinosaur.create! valid_attributes
      expect {
        delete dinosaur_url(dinosaur), headers: valid_headers, as: :json
      }.to change(Dinosaur, :count).by(-1)
    end
  end
end
