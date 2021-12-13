RSpec.describe User do
  describe "associations" do
    it { is_expected.to belong_to :account }
  end
end
