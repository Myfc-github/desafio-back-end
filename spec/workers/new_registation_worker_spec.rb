require "./lib/workers/new_registation_worker"

RSpec.describe "Workers::NewRegistrationWorker" do
  describe "#perform" do
    subject(:perform) { described_class.new.perform(sqs_message, body) }

    let(:sqs_message) { OpenStruct.new(data: body) }
    let(:body) do
      {
        "account" => { "name" => Faker::Superhero.name },
        "users" => [
          {
            "email" => Faker::Internet.email,
            "first_name" => Faker::Name.first_name,
            "last_name" => Faker::Name.last_name,
          },
        ],
      }
    end

    context "when payload is valid" do
      xit "creates a new registration" do
      end
    end

    context "when payload is invalid" do
      xit "raises an error" do
      end
    end
  end
end
