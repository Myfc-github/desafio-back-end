RSpec.describe "Api::V1::RegistrationsController", type: :request do
  describe "POST #create" do
    before { post api_v1_registrations_path(params: params) }

    let(:params) do
      {
        account: {
          name: Faker::Superhero.name, from_partner: true,
          users: [{
            email: Faker::Internet.email,
            first_name: Faker::Name.female_first_name,
            last_name: Faker::Name.last_name,
            phone: Faker::PhoneNumber.cell_phone,
          }],
        },
      }
    end

    it "renders 200 success" do
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to include({ "id" => Account.last.id })
    end
  end
end
