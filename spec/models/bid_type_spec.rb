RSpec.describe BidType do
  it { is_expected.to have_attribute :name }

  it { is_expected.to validate_uniqueness_of :name }

  it { is_expected.to validate_presence_of :name }
end
