class Payment < ApplicationRecord
  DIFFERENT_AMOUNTS = Class.new(StandardError)
  INVALID_DATE_ERROR = 'La fecha de expiracion ya paso'.freeze
  INVALID_NUMBER_ERROR = 'El numero de tarjeta no existe'.freeze
  INVALID_NAME_ERROR = 'El nombre del portador es invalido'.freeze
  VALID_CARD_NUMBER = '4509953566233704'.freeze
  VALID_NAME = 'APRO'.freeze

  # belongs_to :user

  validates_uniqueness_of :token
  validates_presence_of :token, :amount

  after_initialize :assign_token

  class << self
    def validate_credit_card(card_number: nil, expiration_year: nil, expiration_month: nil, name: nil)
      errors = []
      errors << INVALID_DATE_ERROR unless valid_dates(expiration_year, expiration_month)
      errors << INVALID_NUMBER_ERROR unless card_number == '4509953566233704'
      errors << INVALID_NAME_ERROR unless name == 'APRO'

      { valid: errors.empty?, errors: errors }
    end

    def valid_dates(expiration_year, expiration_month)
      current_year = Date.today.strftime('%y').to_i
      valid_month = expiration_year == current_year ? expiration_month > Date.today.month : true
      expiration_year >= current_year && valid_month
    end
  end

  def validate_amount!(another_amount)
    raise DIFFERENT_AMOUNTS unless amount == another_amount
  end

  private

  def assign_token
    token_length = 20
    self.token = rand(36**token_length).to_s(36)
  end
end
