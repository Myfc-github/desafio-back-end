RSpec.describe "Api::V1::RegistrationsController", type: :request do
  describe "POST #create" do
    let(:params) do
      {
        account: {
          name: Faker::Superhero.name, from_partner: true,
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
        },
      }
    end

    it "renders 201 success" do
      stub_request(:post, "https://61b69749c95dd70017d40f4b.mockapi.io/awesome_partner_leads")
        .with(body: { "message" => "new registration", "partner" => "internal" },
          headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Content-Type'=>'application/x-www-form-urlencoded',
        'User-Agent'=>'Faraday v1.8.0'
          })
        .to_return({ status: 201, body: { "id" => "1" }.to_json, headers: {} }) 

      post api_v1_registrations_path(params: params)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to include({ "id" => "1" })
    end

    it "renders 422 error" do
      stub_request(:post, "https://61b69749c95dd70017d40f4b.mockapi.io/awesome_partner_leads")
        .with(body: { "message" => "new registration", "partner" => "internal" },
          headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Content-Type'=>'application/x-www-form-urlencoded',
        'User-Agent'=>'Faraday v1.8.0'
          })
        .to_return({ status: 422, body: {}.to_json, headers: {} }) 

      post api_v1_registrations_path(params: params)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
