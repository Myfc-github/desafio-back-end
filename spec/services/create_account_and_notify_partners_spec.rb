RSpec.describe CreateAccountAndNotifyPartners do
  describe "#call" do
    subject(:call) { described_class.call(params, from_fintera) }

    before { allow(NotifyPartner).to receive(:new).and_return(notify_partner_double) }

    let(:entities) { [{ name: "Empresa Fintera", users: users }] }
    let(:params) { { name: "Fintera - New Account", entities: entities } }
    let(:notify_partner_double) { instance_double(NotifyPartner) }

    context "when some user is from fintera" do
      let(:users) { [{ email: Faker::Internet.email(domain: "fintera.com.br") }] }
      let(:from_fintera) { true }

      it "creates a new account with entity and notifies partner" do
        expect(CreateAccount).to receive(:call).with(params, from_fintera)
        expect(notify_partner_double).to receive(:perform).twice

        call
      end
    end

    context "when users are not from fintera" do
      let(:users) { [{ email: Faker::Internet.email(domain: "example.com") }] }
      let(:from_fintera) { false }

      it "creates a new account with entity and notifies partner" do
        expect(CreateAccount).to receive(:call).with(params, from_fintera)
        expect(notify_partner_double).to receive(:perform).twice

        call
      end
    end
  end
end
