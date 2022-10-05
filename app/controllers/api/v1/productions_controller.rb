class Api::V1::ProductionsController < ApplicationController
  before_action :set_production, only: [:show, :update, :destroy]
  before_action :authenticate_user, only: [:create, :upate, :destroy]
  MAX_PAGINATION_LIMIT = 10

  has_scope :title
  has_scope :genre
  has_scope :score

  # GET /productions
  def index
    @productions = (apply_scopes(Production.limit(limit).offset(params[:offset]))).order(created_at: order)

    render json: @productions
  end

  # GET /productions/1
  def show
    render json: @production
  end

  # POST /productions
  def create
    @production = Production.new(production_params)

    if @production.save
      render json: @production, status: :created
    else
      render json: @production.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /productions/1
  def update
    if @production.update(production_params)
      render json: @production
    else
      render json: @production.errors, status: :unprocessable_entity
    end
  end

  # DELETE /productions/1
  def destroy
    @production.destroy
  end

  private
    def set_production
      @production = Production.find(params[:id])
    end

    def production_params
      params.require(:production).permit(:title, :score, :released_date, :image)
    end

    def limit
      [params.fetch(:limit, MAX_PAGINATION_LIMIT).to_i].min
    end

    def order
      params.fetch(:order, :asc)
    end
end
