class UsersController < ApplicationController

  def create
    User.create!(user_params)

    render json: { status: 'success', code: 200, message: 'Usuario creado correctamente' }
  end

  def balance
    user = User.find_by!(user_params)

    render json: { status: 'success', code: 200, message: "Su saldo actual es de #{user.balance}" }
  end

  private

  def user_params
    params.permit(:username, :password)
  end
end
