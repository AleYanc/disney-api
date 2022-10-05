class Api::V1::ProductionsController < ApplicationController
  before_action :set_production, only: [:show, :update, :destroy]
  before_action :authenticate_user
  MAX_PAGINATION_LIMIT = 10

  has_scope :title
  has_scope :genre
  has_scope :score

  # GET /productions
  def index
    @productions = (apply_scopes(Production.limit(limit).offset(params[:offset]))).order(created_at: order)

    render json: ProductionsSerializer.new(@productions, {params: { context: { index: true }}}).serializable_hash.to_json
  end

  # GET /productions/1
  def show
    render json: ProductionsSerializer.new(@production, {params: { context: { index: false }}}).serializable_hash.to_json
  end

  # POST /productions
  def create
    @production = Production.new(production_params)

    if @production.save
      render json: ProductionsSerializer.new(@production, {params: { context: { index: false }}}).serializable_hash.to_json, status: :created
    else
      render json: @production.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /productions/1
  def update
    if @production.update(production_params)
      render json: ProductionsSerializer.new(@production, {params: { context: { index: false }}}).serializable_hash.to_json
    else
      render json: @production.errors, status: :unprocessable_entity
    end
  end

  # DELETE /productions/1
  def destroy
    @production.destroy
    render json: {'msg': 'Production deleted'}
  end

  private
    def set_production
      @production = Production.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: {error: "No se encuentra la produccion con ID: '#{params[:id]}'"}
    end

    def production_params
      params.permit(:title, :score, :released_date, :image, {:character_ids => []}, {:genre_ids => []})
    end

    def limit
      [params.fetch(:limit, MAX_PAGINATION_LIMIT).to_i].min
    end

    def order
      params.fetch(:order, :asc)
    end
end
