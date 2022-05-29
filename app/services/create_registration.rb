class CreateRegistration < ApplicationService
	def initialize (payload)
		@payload = payload
		@from_partner = payload[:account][:from_partner]
		@many_partners = payload[:account][:many_partners]
	end

	def call
			account = CreateAccount.call(@payload, fintera_users(@payload))
			notifyPartner(@many_partners) if @from_partner 
			return account if account.success?
			account.errors.full_messages
	end
	def fintera_users(payload)
		with_fintera_user = false

    payload[:account][:users].each do |user|
      with_fintera_user = true if user[:email].include? "fintera.com.br"
    end

    with_fintera_user
	end

	def notifyPartner(many_partners)
		NotifyPartner.new.perform
		NotifyPartner.new("another").perform if many_partners
	end

end