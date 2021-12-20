require 'aws-sdk-sqs'
require 'aws-sdk-sts'

module Api
  module V1
    class RegistrationsQueueController < ApplicationController
      def create
        sqs_client = Aws::SQS::Client.new(region: ENV['AWS_REGION'])
      
        receive_messages(sqs_client, ENV['AWS_SQS_QUEUE_URL'])
      end

      private

      def receive_messages(sqs_client, queue_url, max_number_of_messages = 10)
        response = sqs_client.receive_message(
          queue_url: queue_url,
          max_number_of_messages: max_number_of_messages
        )

        response.messages.each do |message|
          NewRegistrationWorker.perform_async(OpenStruct.new(data: message.body), message.body)
        end
      
      rescue StandardError => e
        puts "Error receiving messages: #{e.message}"
      end
    end
  end
end
