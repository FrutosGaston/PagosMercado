class PaymentIntentionController < ApplicationController
  def create
    card_validation = validate_payment
    user = User.find_by(username: intention_params[:username], password: intention_params[:password])
    payment = Payment.create!(amount: intention_params[:amount])

    if card_validation[:valid]
      json_response({message: 'La operacion se inicio con exito', token: payment.token }, 200)
    else
      json_response({message: 'La tarjeta es invalida', errors: card_validation[:errors] }, 400)
    end
  end

  private

  def amount
    @amount ||= params[:amount].to_f
  end

  def current_payment
    @current_payment ||= Payment.find_by!(token: params[:token])
  end

  def validate_payment
    Payment.validate_credit_card(
        card_number: intention_params[:card_number], expiration_year: intention_params[:expiration_year].to_i,
        expiration_month: intention_params[:expiration_month].to_i, name: intention_params[:name]
    )
  end

  def intention_params
    params.permit(:username, :password, :amount, :card_number, :expiration_year, :expiration_month, :name)
  end
end
