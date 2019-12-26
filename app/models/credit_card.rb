class CreditCard
  INVALID_DATE_ERROR = 'La fecha de expiracion ya paso'.freeze
  INVALID_NUMBER_ERROR = 'El numero de tarjeta no existe'.freeze
  INVALID_NAME_ERROR = 'El nombre del portador es invalido'.freeze
  VALID_CARD_NUMBER = '4509953566233704'.freeze
  VALID_NAME = 'APRO'.freeze

  attr_accessor :card_number, :expiration_year, :expiration_month, :name

  def initialize(card_number, expiration_year, expiration_month, name, cvv)
    @card_number = card_number
    @expiration_year = expiration_year
    @expiration_month = expiration_month
    @name = name
    @cvv = cvv
  end

  def validate
    errors = []
    errors << INVALID_DATE_ERROR unless valid_dates(expiration_year, expiration_month)
    errors << INVALID_NUMBER_ERROR unless card_number == VALID_CARD_NUMBER
    errors << INVALID_NAME_ERROR unless name == VALID_NAME

    { valid: errors.empty?, errors: errors }
  end

  def valid_dates(expiration_year, expiration_month)
    current_year = Date.today.strftime('%y').to_i
    expires_this_year = expiration_year == current_year
    valid_month = expires_this_year ? expiration_month > Date.today.month : true
    expiration_year >= current_year && valid_month
  end
end