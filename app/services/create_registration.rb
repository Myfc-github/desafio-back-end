class CreateRegistration < ApplicationService
	def initialize (payload)
		@payload = payload
	end

	def call
			verify_partner
			account = CreateAccount.call(@payload, fintera_users(@payload))
			notifyPartner(@many_partners) if @from_partner 
			return account
	end

	def fintera_users(payload)
		with_fintera_user = false

    payload[:users].each do |user|
      with_fintera_user = true if user[:email].include? "fintera.com.br"
    end

    with_fintera_user
	end

	def verify_partner
		@from_partner = @payload[:from_partner] if @payload[:from_partner].present?
		@many_partners = @payload[:many_partners] if @payload[:many_partners].present?

	end

	def notifyPartner(many_partners)
		NotifyPartner.new.perform
		NotifyPartner.new("another").perform if many_partners
	end

end