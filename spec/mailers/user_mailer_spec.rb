RSpec.describe UserMailer do
  let(:user) { create(:user) }
  let(:call_to_action) { { label: "Action X", url: "http://example.com" } }

  describe "#welcome_email" do
    subject(:welcome_email) { described_class.welcome_email(user, call_to_action) }

    it "renders the subject" do
      expect(welcome_email.subject).to eql "Seja bem-vindo à Fintera!"
    end

    it "renders the receiver email" do
      expect(welcome_email.to).to eql [user.email]
    end

    it "renders the sender email" do
      expect(welcome_email.from).to eql ["desafio@fintera.com.br"]
    end

    it "renders link according to call to action" do
      expect(welcome_email.body).to include("http://example.com")
    end
  end
end
