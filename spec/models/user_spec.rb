RSpec.describe User do
  describe "associations" do
    it { is_expected.to have_and_belong_to_many :entities }
  end
end
