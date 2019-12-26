class PaymentIntentionController < ApplicationController
  def create
    card_validation = validate_card

    if card_validation[:valid]
      payment = Payment.create!(amount: intention_params[:amount])
      json_response({message: 'La operacion se inicio con exito', token: payment.token })
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

  def validate_card
    credit_card_params = intention_params[:credit_card]
    CreditCard.new(
        credit_card_params[:card_number], credit_card_params[:expiration_year].to_i,
        credit_card_params[:expiration_month].to_i, credit_card_params[:name], credit_card_params[:cvv]
    ).validate
  end

  def intention_params
    params.permit(:amount, credit_card: [:card_number, :expiration_year, :expiration_month, :name, :cvv])
  end
end
