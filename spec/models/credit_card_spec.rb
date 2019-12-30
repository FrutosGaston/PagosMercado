require 'rails_helper'

describe CreditCard do
  describe 'Validate that the credit card exists' do
    it 'when the attributes are the expected ones' do
      next_year = 1.year.from_now.strftime('%y').to_i
      valid = described_class.new(CreditCard::VALID_CARD_NUMBER, next_year, 12, CreditCard::VALID_NAME,
                                  CreditCard::VALID_CVV).validate

      expect(valid).to eq(valid: true, errors: [])
    end

    it 'when the expiration date already happened' do
      year_ago = 1.year.ago.strftime('%y').to_i
      valid = described_class.new(CreditCard::VALID_CARD_NUMBER, year_ago, 12, CreditCard::VALID_NAME,
                                  CreditCard::VALID_CVV).validate

      expect(valid[:valid]).to eq false
      expect(valid[:errors].length).to eq 1
    end

    it 'when the card number is not the expected one' do
      next_year = 1.year.from_now.strftime('%y').to_i
      fake_card_number = '45213516512356'
      valid = described_class.new(fake_card_number, next_year, 12, CreditCard::VALID_NAME,
                                  CreditCard::VALID_CVV).validate

      expect(valid[:valid]).to eq false
      expect(valid[:errors].length).to eq 1
    end

    it 'when the name is not the expected one' do
      next_year = 1.year.from_now.strftime('%y').to_i
      another_name = 'Pepito'
      valid = described_class.new(CreditCard::VALID_CARD_NUMBER, next_year, 12, another_name,
                                  CreditCard::VALID_CVV).validate

      expect(valid[:valid]).to eq false
      expect(valid[:errors].length).to eq 1
    end

    it 'when there are two errors' do
      next_year = 1.year.from_now.strftime('%y').to_i
      fake_card_number = '45213516512356'
      another_name = 'Pepito'
      valid = described_class.new(fake_card_number, next_year, 12, another_name,
                                  CreditCard::VALID_CVV).validate

      expect(valid[:valid]).to eq false
      expect(valid[:errors].length).to eq 2
    end
  end
end
