class PaymentsController < ApplicationController

  def start
    Payment.validate_credit_card!(card_number: start_params[:card_number], expiration_year: start_params[:expiration_year].to_i,
                                  expiration_month: start_params[:expiration_month].to_i, name: start_params[:name])
    user = User.where(username: start_params[:username], password: start_params[:password]).first
    payment = Payment.create!(amount: start_params[:amount], user: user)

    render json: { status: 'success', code: 200, message: 'La operacion se inicio con exito', data: { token: payment.token } }
  rescue Payment::INVALID_CARD
    error_json('400', 'La tarjeta es invalida', 'No se puede procesar la tarjeta enviada')
  end

  def credit
    payment = Payment.find_by!(token: params[:token])
    amount = params[:amount].to_f
    payment.validate_amount!(amount)
    payment.user.increment(:balance, by: amount)

    render json: { status: 'success', code: 200, message: 'El pago se realizo exitosamente!' }
  rescue RecordNotFound
    payment.update(failed: true)
    error_json('404', 'La operacion no existe', 'No se pudo encontrar una operacion con el token dado')
  rescue Payment::DIFFERENT_AMOUNTS
    payment.update(failed: true)
    error_json('400', 'Precios diferentes', 'No se pudo procesar el pago porque los montos ingresados no coinciden')
  end

  private

  def start_params
    params.permit(:username, :password, :amount, :card_number, :expiration_year, :expiration_month, :name)
  end
end
