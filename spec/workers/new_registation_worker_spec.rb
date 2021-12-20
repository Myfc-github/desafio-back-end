require "./lib/workers/new_registation_worker"

RSpec.describe Workers::NewRegistrationWorker do
  describe "#perform" do
    subject(:perform) { described_class.new.perform(sqs_message, body) }

    let(:fake_result) { ApplicationService::Result.new(true) }

    let(:sqs_message) { OpenStruct.new(data: body) }
    let(:nome) { Faker::Superhero.name }
    let(:body) do
      {
        "account" => { 
          "name" => nome,
          "entities" => [{
            "name" => Faker::Superhero.name,
            "users" => [
              {
                "email" => Faker::Internet.email,
                "first_name" => Faker::Name.first_name,
                "last_name" => Faker::Name.last_name,
              },
            ],
          }],
        },
      }
    end

    context "when payload is valid" do
      let(:expected_result) { ApplicationService::Result.new(true, Account.last) }
      it "creates a new registration" do

      is_expected.to eql(expected_result)
      end
    end

    context "when payload is invalid" do
      let(:nome) { "" }
      let(:expected_result) { ApplicationService::Result.new(false, nil, "Name can't be blank") }
      it "raises an error" do
        is_expected.to eql(expected_result)
      end
    end
  end
end
