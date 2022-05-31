RSpec.describe EntityUser do
  describe "associations" do
    it { is_expected.to belong_to :entity }
    it { is_expected.to belong_to :user }
  end
end
