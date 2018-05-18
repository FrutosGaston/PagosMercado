require 'rails_helper'

describe Payment do
  it { expect(subject).to validate_presence_of :token }
  it { expect(subject).to validate_presence_of :amount }
  it { expect(subject).to validate_uniqueness_of :token }

  describe 'Validate that the credit card exists' do
    it 'when the attributes are the expected ones' do
      next_year = 1.year.from_now.strftime('%y').to_i
      valid = described_class.validate_credit_card(card_number: Payment::VALID_CARD_NUMBER, name: Payment::VALID_NAME,
                                                   expiration_year: next_year, expiration_month: 12)

      expect(valid).to eq(valid: true, errors: [])
    end

    it 'when the expiration date already happened' do
      year_ago = 1.year.ago.strftime('%y').to_i
      valid = described_class.validate_credit_card(card_number: Payment::VALID_CARD_NUMBER, name: Payment::VALID_NAME,
                                                   expiration_year: year_ago, expiration_month: 12)

      expect(valid[:valid]).to eq false
      expect(valid[:errors].length).to eq 1
    end

    it 'when the card number is not the expected one' do
      next_year = 1.year.from_now.strftime('%y').to_i
      fake_card_number = '45213516512356'
      valid = described_class.validate_credit_card(card_number: fake_card_number, name: Payment::VALID_NAME,
                                                   expiration_year: next_year, expiration_month: 12)

      expect(valid[:valid]).to eq false
      expect(valid[:errors].length).to eq 1
    end

    it 'when the name is not the expected one' do
      next_year = 1.year.from_now.strftime('%y').to_i
      another_name = 'Pepito'
      valid = described_class.validate_credit_card(card_number: Payment::VALID_CARD_NUMBER, name: another_name,
                                                   expiration_year: next_year, expiration_month: 12)

      expect(valid[:valid]).to eq false
      expect(valid[:errors].length).to eq 1
    end

    it 'when there are two errors' do
      next_year = 1.year.from_now.strftime('%y').to_i
      fake_card_number = '45213516512356'
      another_name = 'Pepito'
      valid = described_class.validate_credit_card(card_number: fake_card_number, name: another_name,
                                                   expiration_year: next_year, expiration_month: 12)

      expect(valid[:valid]).to eq false
      expect(valid[:errors].length).to eq 2
    end
  end
end
