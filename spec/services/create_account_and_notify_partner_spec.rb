RSpec.describe CreateAccountAndNotifyPartner do
  describe "#call" do
    subject(:call) { described_class.call(params) }

    before { allow(NotifyPartner).to receive(:new).and_return(notify_partner_double) }

    let(:params) { { name: "Fintera - New Account", users: users } }
    let(:notify_partner_double) { instance_double(NotifyPartner) }

    context "when some user is from fintera" do
      let(:users) { [{ email: Faker::Internet.email(domain: "fintera.com.br") }] }

      it "creates a new account and notifies partner" do
        expect(CreateAccount).to receive(:call).with(params, true)
        expect(notify_partner_double).to receive(:perform)

        call
      end
    end

    context "when users are not from fintera" do
      let(:users) { [{ email: Faker::Internet.email(domain: "example.com") }] }

      it "creates a new account and notifies partner" do
        expect(CreateAccount).to receive(:call).with(params, false)
        expect(notify_partner_double).to receive(:perform)

        call
      end
    end
  end
end
