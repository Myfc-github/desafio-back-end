module Workers
  class NewRegistrationWorker
    include Sidekiq::Worker
    include Sidekiq::Symbols

    def perform(sqs_message, body)
      CreateRegistration.call(body[:account])
    end
  end
end
