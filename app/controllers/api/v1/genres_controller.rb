class Api::V1::GenresController < ApplicationController
  before_action :set_genre, only: [:show, :update, :destroy]
  before_action :authenticate_user
  MAX_PAGINATION_LIMIT = 10

  has_scope :by_name

  # GET /genres
  def index
    @genres = (apply_scopes(Genre.limit(limit).offset(params[:offset]))).order(created_at: order)

    render json: GenresSerializer.new(@genres).serializable_hash.to_json
  end

  # GET /genres/1
  def show
    render json: GenresSerializer.new(@genre).serializable_hash.to_json
  end

  # POST /genres
  def create
    @genre = Genre.new(genre_params)

    if @genre.save
      render json: @genre, status: :created
    else
      render json: @genre.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /genres/1
  def update
    if @genre.update(genre_params)
      render json: @genre
    else
      render json: @genre.errors, status: :unprocessable_entity
    end
  end

  # DELETE /genres/1
  def destroy
    @genre.destroy
  end

  private

  def limit
    [params.fetch(:limit, MAX_PAGINATION_LIMIT).to_i].min
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_genre
    @genre = Genre.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {error: "No se encuentra el genero con ID: '#{params[:id]}'"}
  end

  # Only allow a list of trusted parameters through.
  def genre_params
    params.require(:genre).permit(:name, :image)
  end

  def order
    params.fetch(:order, :asc)
  end
end
