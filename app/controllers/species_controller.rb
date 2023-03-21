# Controller class for Species model
class SpeciesController < ApplicationController
  before_action :set_species, only: %i[show update destroy]

  # GET /species
  # GET /species.json
  def index
    @species = Species.all
  end

  # GET /species/1
  # GET /species/1.json
  def show; end

  # POST /species
  # POST /species.json
  def create
    @species = Species.new(species_params)

    if @species.save
      render :show, status: :created, location: @species
    else
      render json: @species.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /species/1
  # PATCH/PUT /species/1.json
  def update
    if @species.update(species_params)
      render :show, status: :ok, location: @species
    else
      render json: @species.errors, status: :unprocessable_entity
    end
  end

  # DELETE /species/1
  # DELETE /species/1.json
  def destroy
    @species.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_species
    @species = Species.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def species_params
    params.require(:species).permit(:name, :dinosaur_type)
  end
end
