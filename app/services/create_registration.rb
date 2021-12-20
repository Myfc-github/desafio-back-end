class CreateRegistration < ApplicationService

  attr_accessor :payload

  def initialize(payload)
    @payload = payload
  end

  def call
    if payload[:from_partner] && payload[:many_partners]
      result = create_account_and_notify_partners
    elsif payload[:from_partner]
      result = create_account_and_notify_partner
    else
      result = create_account
    end

    result
  end

  private

  def create_account_and_notify_partner
    CreateAccountAndNotifyPartner.call(payload, fintera_users)
  end

  def create_account_and_notify_partners
    CreateAccountAndNotifyPartners.call(payload, fintera_users)
  end

  def create_account
    from_fintera = payload[:name].include?("Fintera") && fintera_users
    CreateAccount.call(payload, from_fintera)
  end

  def fintera_users
    payload[:entities].each do |entity|
      entity[:users].each do |user|
        return true if user[:email].include? "fintera.com.br"
      end
    end

    false
  end
end
