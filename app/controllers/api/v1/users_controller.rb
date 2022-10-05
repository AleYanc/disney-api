class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    # Nada para hacer aqui
  end

  # GET /users/1
  def show
    # Nada para hacer aqui
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      UserSignUpMailer.send_signup_email(@user).deliver
      @token = AuthTokenService.call(@user.id)
      render json: {'msg': 'Registrado con exito', 'email': @user.email, 'first-token': "#{@token}"}, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    # Nada para hacer aqui
  end

  # DELETE /users/1
  def destroy
    # Nada para hacer aqui
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
