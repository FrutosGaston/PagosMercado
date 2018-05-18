class PaymentsController < ApplicationController
  def start
    card_validation = validate_payment
    # user = User.find_by(username: start_params[:username], password: start_params[:password])
    payment = Payment.create!(amount: start_params[:amount])

    if card_validation[:valid]
      render json: { status: 'success', code: 200, message: 'La operacion se inicio con exito',
                     data: { token: payment.token } }, status: 200
    else
      error_json('400', 'La tarjeta es invalida', card_validation[:errors])
    end
  end

  def credit
    complete_payment
    render json: { status: 'success', code: 200, message: 'El pago se realizo exitosamente!' }, status: 200
  rescue ActiveRecord::RecordNotFound
    error_json('404', 'La operacion no existe', 'No se pudo encontrar una operacion con el token dado')
  rescue Payment::DIFFERENT_AMOUNTS
    current_payment.update(failed: true)
    error_json('400', 'Precios diferentes', 'No se pudo procesar el pago porque los montos ingresados no coinciden')
  end

  private

  def complete_payment
    current_payment.validate_amount!(amount)
    # current_payment.user.increment(:balance, amount)
  end

  def amount
    @amount ||= params[:amount].to_f
  end

  def current_payment
    @current_payment ||= Payment.find_by!(token: params[:token])
  end

  def validate_payment
    Payment.validate_credit_card(
      card_number: start_params[:card_number], expiration_year: start_params[:expiration_year].to_i,
      expiration_month: start_params[:expiration_month].to_i, name: start_params[:name]
    )
  end

  def start_params
    params.permit(:username, :password, :amount, :card_number, :expiration_year, :expiration_month, :name)
  end
end
