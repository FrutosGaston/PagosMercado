class UsersController < ApplicationController

  before_action :set_user, only: [:show]

  def create
    user = User.new(user_params)

    user.save!
    json_response({ message: 'Usuario creado correctamente', user: user })
  end

  def show
    json_response(@user, 200)
  end

  private

  def user_params
    params.permit(:username, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
