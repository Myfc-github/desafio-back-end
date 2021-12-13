RSpec.describe Account do
  describe "associations" do
    it { is_expected.to have_many :users }
  end
end
