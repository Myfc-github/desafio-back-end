RSpec.describe "Api::V1::RegistrationsController", type: :request do
  describe "POST #create" do
    before { post api_v1_registrations_path(params: params) }
    

    context "When params are corret" do
      let(:params) do
        {
          account: {
            name: Faker::Superhero.name,
            entity_name: Faker::Company.name,
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
        expect(JSON.parse(response.body)).to include({ "message" => "Registro realizado com sucesso" })
      end
    end

    context "When params are incorrect" do
      let(:params) do
        {
          account: {
            users: [{
              email: Faker::Internet.email,
              first_name: Faker::Name.female_first_name,
              last_name: Faker::Name.last_name,
              phone: Faker::PhoneNumber.cell_phone,
            }],
          }
        }
      end

      it "renders unprocessable_entity" do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include({ "error" => "Name can't be blank" })

      end
    end
  end
end
