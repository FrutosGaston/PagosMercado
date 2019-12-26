class Payment < ApplicationRecord
  DIFFERENT_AMOUNTS = Class.new(StandardError)

  # belongs_to :user

  validates_uniqueness_of :token
  validates_presence_of :token, :amount

  after_initialize :assign_token

  def validate_amount!(another_amount)
    raise DIFFERENT_AMOUNTS unless amount == another_amount
  end

  private

  def assign_token
    token_length = 20
    self.token = rand(36**token_length).to_s(36)
  end
end
