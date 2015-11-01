RSpec.describe Donor do
  it { is_expected.to belong_to :user }

  it { is_expected.to belong_to :auction }

  it { is_expected.to validate_presence_of :user }

  it { is_expected.to validate_presence_of :auction }
end
