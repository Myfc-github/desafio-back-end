require 'aws-sdk-sqs'
require 'aws-sdk-sts'

RSpec.describe "Api::V1::RegistrationsQueueController", type: :request do
  describe "POST #create" do

    it "renders 200" do 
      stub_request(:post, "https://sqs.us-east-1.amazonaws.com/123456789012/my_queue").
      and_return(status: 200, body: "messages: [
        {
          message_id: '1',
          receipt_handle: 'Something',
          body: 
          {
            'account' => { 
              'name' => #{Faker::Superhero.name} ,
              'entities' => {
                'name' => #{Faker::Superhero.name} ,
                'users' => [
                  {
                    'email' => #{Faker::Internet.email},
                    'first_name' => #{Faker::Name.first_name},
                    'last_name' => #{Faker::Name.last_name},
                  },
                ],
              },
            },
          }
        }
      ]", headers: {})

      post api_v1_registrations_queue_index_path()

      expect(response).to have_http_status(:no_content)
    end
  end
end
