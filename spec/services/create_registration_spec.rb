RSpec.describe CreateRegistration do
  describe "#call" do
    subject(:call) { described_class.call(payload) }

    let(:fake_result) { ApplicationService::Result.new(true) }

    context "when account is from partner" do
      let(:payload) do
        {
          name: Faker::Company.name,
          from_partner: true,
          users: [
            {
              first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email,
              phone: "(11) 97111-0101",
            },
          ],
        }
      end

      it "calls CreateAccountAndNotifyPartner service" do
        expect(CreateAccountAndNotifyPartner).to receive(:call).with(payload).and_return(fake_result)

        call
      end
    end

    context "when account is from many partners" do
      let(:payload) do
        {
          name: Faker::Company.name,
          from_partner: true,
          many_partners: true,
          users: [
            {
              first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email,
              phone: "(11) 97111-0101",
            },
          ],
        }
      end

      it "calls CreateAccountAndNotifyPartner service" do
        expect(CreateAccountAndNotifyPartners).to receive(:call).with(payload).and_return(fake_result)

        call
      end
    end

    context "when account is not from a partner" do
      let(:payload) do
        {
          name: "Fintera - #{Faker::Company.name}",
          users: [
            {
              first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: Faker::Internet.email,
              phone: "(11) 97111-0101",
            },
          ],
        }
      end

      it "calls CreateAccount service" do
        expect(CreateAccount).to receive(:call).with(payload, false).and_return(fake_result)

        call
      end
    end
  end
end
