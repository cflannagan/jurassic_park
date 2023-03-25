# Controller class for Dinosaur model
class DinosaursController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_dinosaur, only: %i[show update destroy]

  # GET /dinosaurs
  # GET /dinosaurs.json
  def index # rubocop:disable Metrics/AbcSize
    @dinosaurs = Dinosaur.all
    @dinosaurs = @dinosaurs.caged if params.key?(:caged)
    @dinosaurs = @dinosaurs.not_caged if params.key?(:not_caged)
    @dinosaurs = @dinosaurs.carnivore if params.key?(:carnivore)
    @dinosaurs = @dinosaurs.herbivore if params.key?(:herbivore)
    @dinosaurs = @dinosaurs.by_species_name(params[:species]) if params[:species]
    @dinosaurs.joins(:species)
  end

  # GET /dinosaurs/1
  # GET /dinosaurs/1.json
  def show; end

  # POST /dinosaurs
  # POST /dinosaurs.json
  def create
    @dinosaur = Dinosaur.new(dinosaur_params)

    if @dinosaur.save
      render :show, status: :created, location: @dinosaur
    else
      render json: @dinosaur.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dinosaurs/1
  # PATCH/PUT /dinosaurs/1.json
  def update
    if @dinosaur.update(dinosaur_params)
      render :show, status: :ok, location: @dinosaur
    else
      render json: @dinosaur.errors, status: :unprocessable_entity
    end
  end

  # DELETE /dinosaurs/1
  # DELETE /dinosaurs/1.json
  def destroy
    @dinosaur.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dinosaur
    @dinosaur = Dinosaur.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def dinosaur_params
    params.require(:dinosaur).permit(:name, :species_id, :cage_id)
  end
end
