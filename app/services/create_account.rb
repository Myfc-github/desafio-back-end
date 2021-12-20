class CreateAccount < ApplicationService

  attr_accessor :payload, :from_fintera, :errors

  def initialize(payload, from_fintera = false)
    @payload = payload
    @from_fintera = from_fintera
    @errors = []
  end

  def call
    if account_valid?
      account = Account.new(account_params)

      if account.save 
        entities_params(account).each do |entity|
          users = User.create(users_params(entity))
          entity = entity.except(:users)
          entity_saving = Entity.new(entity)
          entity_saving.users << users
          entity_saving.save
        end
        return Result.new(true, account)
      end
      errors << account.errors.full_messages
    else
      errors << "Account is not valid"
    end
    Result.new(false, nil, errors.join(","))
  end

  def account_valid?
    payload.present?
  end

  def account_params
    {
      name: payload[:name],
      active: from_fintera,
    }
  end

  def entities_params(account)
    payload[:entities].map do |entity|
      {
        name: entity[:name],
        account_id: account.id,
        created_at: Time.zone.now,
        updated_at: Time.zone.now,
        users: users_params(entity),
      }
    end
  end

  def users_params(entity)
    entity[:users].map do |user|
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
