RSpec.describe Account do
  describe "associations" do
    it { is_expected.to have_many :entities }
  end
end
