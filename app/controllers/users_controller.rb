class UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      render json: { status: 'success', code: 200, message: 'Usuario creado correctamente' }, status: 200
    else
      error_json(400, 'Error al crear el usuario', 'No se pudo crear un usuario con los datos enviados.')
    end
  end

  def balance
    user = User.find_by(user_params)

    if user.present?
      render json: { status: 'success', code: 200, message: "Su saldo actual es de #{user.balance}" }, status: 200
    else
      error_json(404, 'El usuario no existe', 'No se pudo encontrar un usuario con los datos enviados')
    end
  end

  private

  def user_params
    params.permit(:username, :password)
  end
end
