class CreateAccount < ApplicationService
  def initialize(payload, from_fintera = false)
    @payload = payload[:account]
    @from_fintera = from_fintera
    @users =  @payload[:users]
    @erros = []
  end

  def call
    @errors << "Account is not valid" if @payload.blank?
    @account = Account.new(account_params)
    @errors << @account.errors.full_messages unless @account.save

    users = []
    users_params(@account).each do |user_param|
      users << User.create(user_param)
    end
    return create_result
  end

  private

  def create_result
    return Result.new(true, @account) unless @errors.present?
    return Result.new(false, nil, @errors.join(", "))
  end

  def account_params
    return {name: @payload[:name], active: false} unless @from_fintera
    {name: @payload[:name], active: true} 
  end
  
  def users_params(account)
    @users.map do |user|
      {
        first_name: user[:first_name],
        last_name: user[:last_name],
        email: user[:email],
        phone: user[:phone].to_s.gsub(/\D/, ""),
        account_id: account.id,
        created_at: Time.zone.now,
        updated_at: Time.zone.now,
      }
    end
  end
end