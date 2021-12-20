require 'rails_helper'

RSpec.describe Entity, type: :model do
  describe "associations" do
    it { is_expected.to have_and_belong_to_many :users }
  end

  
  describe "presence of name" do
    it { is_expected.to validate_presence_of(:name) }
  end
end
