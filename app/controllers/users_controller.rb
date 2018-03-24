class UsersController < ApplicationController

  def create
    User.create!(user_params)

    head :ok
  end

  def balance
    user = User.find_by!(user_params)

    render json: { status: 200, message: "Su saldo actual es de #{user.balance}" }
  end

  private

  def user_params
    params.permit(:username, :password)
  end
end
