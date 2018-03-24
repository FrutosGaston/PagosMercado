class Payment < ApplicationRecord
  DIFFERENT_AMOUNTS = Class.new(StandardError)
  INVALID_CARD = Class.new(StandardError)

  belongs_to :user

  validates_uniqueness_of :token
  validates_presence_of :token, :amount

  after_initialize :assign_token

  def self.validate_credit_card!(card_number: '4509953566233704', expiration_year: 20, expiration_month: 5, name: 'APRO')
    current_year = DateTime.now.year - 2000
    valid_month = expiration_year == current_year ? expiration_month > DateTime.now.month : true
    valid_dates = expiration_year >= current_year && valid_month
    valid_card = card_number == '4509953566233704' && name == 'APRO' && valid_dates

    raise INVALID_CARD unless valid_card
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
