class PaymentsController < ApplicationController

  def create
    complete_payment
    message_response 'El pago se realizo exitosamente'
  rescue Payment::DIFFERENT_AMOUNTS
    current_payment.update(failed: true)
    message_response 'No se pudo procesar el pago porque los montos ingresados no coinciden', 400
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

end
