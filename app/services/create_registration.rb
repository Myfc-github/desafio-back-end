class CreateRegistration < ApplicationService
  def initialize(payload)
    @payload = payload
  end

  def call
    if @payload[:from_partner] == true && @payload[:many_partners] == true
      @result = create_account_and_notify_partners
    elsif @payload[:from_partner] == true
      @result = create_account_and_notify_partner
    else
      @result = create_account
    end

    return Result.new(true, @result.data) if @result.success?

    @result
  end

  private

  def create_account_and_notify_partner
    CreateAccountAndNotifyPartner.call(@payload)
  end

  def create_account_and_notify_partners
    CreateAccountAndNotifyPartners.call(@payload)
  end

  def create_account
    if @payload[:name].include?("Fintera") && fintera_users(@payload) == true
      CreateAccount.call(@payload, true)
    else
      CreateAccount.call(@payload, false)
    end
  end

  def fintera_users(payload)
    with_fintera_user = false

    payload[:users].each do |user|
      with_fintera_user = true if user[:email].include? "fintera.com.br"
    end

    with_fintera_user
  end
end
