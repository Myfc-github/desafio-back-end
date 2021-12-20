RSpec.describe CreateRegistration do
  describe "#call" do
    subject(:call) { described_class.call(payload) }

    let(:fake_result) { ApplicationService::Result.new(true) }

    context "when account is from partner" do
      let(:payload) do
        {
          name: Faker::Company.name,
          from_partner: true,
          entities: [
            {
              name: Faker::Company.name,
              users: [
                {
                  first_name: Faker::Name.first_name,
                  last_name: Faker::Name.last_name,
                  email: email,
                  phone: "(11) 97111-0101",
                },
              ],
            },
          ],
        }
      end

      context "when some user is from fintera" do
        let(:email) { "fintera.com.br" }
        let(:from_fintera) { true }
        it "calls CreateAccountAndNotifyPartner service" do
          allow(CreateAccountAndNotifyPartner).to receive(:call).with(payload, from_fintera).and_return(fake_result)

          call
        end
      end

      context "when users are not from fintera" do
        let(:email) { "other.com.br" }
        let(:from_fintera) { false }
        it "calls CreateAccountAndNotifyPartner service" do
          allow(CreateAccountAndNotifyPartner).to receive(:call).with(payload, from_fintera).and_return(fake_result)

          call
        end
      end
    end

    context "when account is from many partners" do
      let(:payload) do
        {
          name: Faker::Company.name,
          from_partner: true,
          many_partners: true,
          entities: [
            {
              name: Faker::Company.name,
              users: [
                {
                  first_name: Faker::Name.first_name,
                  last_name: Faker::Name.last_name,
                  email: email,
                  phone: "(11) 97111-0101",
                },
              ],
            },
          ],
        }
      end

      context "when some user is from fintera" do
        let(:email) { "fintera.com.br" }
        let(:from_fintera) { true }
        it "calls CreateAccountAndNotifyPartner service" do
          allow(CreateAccountAndNotifyPartners).to receive(:call).with(payload, from_fintera).and_return(fake_result)

          call
        end
      end

      context "when users are not from fintera" do
        let(:email) { "other.com.br" }
        let(:from_fintera) { false }
        it "calls CreateAccountAndNotifyPartner service" do
          allow(CreateAccountAndNotifyPartners).to receive(:call).with(payload, from_fintera).and_return(fake_result)

          call
        end
      end
    end

    context "when account is not from a partner" do
      let(:payload) do
        {
          name: "Fintera - #{Faker::Company.name}",
          entities: [
            {
              name: Faker::Company.name,
              users: [
                {
                  first_name: Faker::Name.first_name,
                  last_name: Faker::Name.last_name,
                  email: Faker::Internet.email,
                  phone: "(11) 97111-0101",
                },
              ],
            },
          ],
        }
      end

      it "calls CreateAccount service" do
        allow(CreateAccount).to receive(:call).with(payload, false).and_return(fake_result)

        call
      end
    end

    context "when account is not from a partner and have fintera users" do
      let(:payload) do
        {
          name: "Fintera - #{Faker::Company.name}",
          entities: [
            {
              name: Faker::Company.name,
              users: [
                {
                  first_name: Faker::Name.first_name,
                  last_name: Faker::Name.last_name,
                  email: "fintera.com.br",
                  phone: "(11) 97111-0101",
                },
              ],
            },
          ],
        }
      end

      it "calls CreateAccount service" do
        allow(CreateAccount).to receive(:call).with(payload, true).and_return(fake_result)

        call
      end
    end
  end
end
