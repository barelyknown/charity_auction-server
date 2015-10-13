RSpec.describe Membership do
  it { is_expected.to belong_to :user }

  it { is_expected.to belong_to :organization }

  it { is_expected.to validate_presence_of :user }

  it { is_expected.to validate_presence_of :organization }
end
