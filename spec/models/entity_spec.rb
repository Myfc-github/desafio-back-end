RSpec.describe Entity do
  describe "associations" do
    it { is_expected.to belong_to :account }
    it { is_expected.to have_many :entity_user }
  end
end
