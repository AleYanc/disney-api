class Api::V1::CharactersController < ApplicationController
  before_action :set_character, only: [:show, :update, :destroy]
  before_action :authenticate_user

  has_scope :by_name
  has_scope :by_age, using: [:from, :to]
  has_scope :by_weight, using: [:from, :to]
  has_scope :by_production
  MAX_PAGINATION_LIMIT = 10

  # GET /characters
  def index
    @characters = (apply_scopes(Character.limit(limit).offset(params[:offset]))).order(created_at: order_params)
    render json: CharactersSerializer.new(@characters, {params: { context: { index: true }}}).serializable_hash.to_json
  end

  # GET /characters/1
  def show
    render json: CharactersSerializer.new(@character, {params: { context: { index: false }}}).serializable_hash.to_json
  end

  # POST /characters
  def create
    @character = Character.new(character_params)

    if @character.save
      render json: CharactersSerializer.new(@character, {params: { context: { index: false }}}).serializable_hash.to_json, status: :created
    else
      render json: @character.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /characters/1
  def update
    if @character.update(character_params)
      render json: CharactersSerializer.new(@character, {params: { context: { index: false }}}).serializable_hash.to_json
    else
      render json: @character.errors, status: :unprocessable_entity
    end
  end

  # DELETE /characters/1
  def destroy
    @character.destroy
    render json: {'msg': 'Character deleted'}
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_character
    @character = Character.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: "No se encuentra el personaje con ID: '#{params[:id]}'"}
  end

  # Only allow a list of trusted parameters through.
  def character_params
    params.permit(:name, :age, :weight, :history, :image, {:production_ids => []})
  end

  def limit
    [params.fetch(:limit, MAX_PAGINATION_LIMIT).to_i].min
  end

  def order_params
    @order = params.fetch(:order, "ASC")
  end
end
