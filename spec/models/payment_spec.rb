require 'rails_helper'

describe Payment do
  it { expect(subject).to validate_presence_of :token }
  it { expect(subject).to validate_presence_of :amount }
  it { expect(subject).to validate_uniqueness_of :token }
end
