class CreateAccount < ApplicationService
  def initialize(payload, from_fintera = false)
    @payload = payload
    @from_fintera = from_fintera
    @errors = []
    
  end

  def call
    @errors << "Account is not valid" if @payload.blank?
    return create_result if @errors.present?

    @account = Account.create(account_params)
    @errors << @account.errors.full_messages unless @account.save
    return create_result if @errors.present?

    entity = Entity.create(name: @payload[:entity_name], account: @account)
    @errors << entity.errors.full_messages unless entity.save
    return create_result if @errors.present?
    
    users = []
    users_params.each do |user_param|
      puts user_param[:email]
      user = User.create(user_param)
      @errors << user.errors.full_messages unless user.save
      return create_result if @errors.present?

      users << user
    end

    users.each do |user|
      entity_user = EntityUser.create(user: user, entity: entity)
      @errors << entity_user.errors.full_messages unless entity_user.save
      return create_result if @errors.present?
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
  
  def users_params
    @payload[:users].map do |user|
      {
        first_name: user[:first_name],
        last_name: user[:last_name],
        email: user[:email],
        phone: user[:phone].to_s.gsub(/\D/, ""),
        created_at: Time.zone.now,
        updated_at: Time.zone.now,
      }
    end
  end
end