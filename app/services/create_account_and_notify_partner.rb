class CreateAccountAndNotifyPartner < ApplicationService

  attr_accessor :params, :from_fintera

  def initialize(data, from_fintera)
    @params = data
    @from_fintera = from_fintera
  end

  def call
    CreateAccount.call(params, from_fintera)
    NotifyPartner.new.perform
  end
end
