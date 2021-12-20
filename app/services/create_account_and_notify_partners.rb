class CreateAccountAndNotifyPartners < ApplicationService

  attr_accessor :params, :from_fintera

  def initialize(data, from_fintera)
    @params = data
    @from_fintera = from_fintera
  end

  def call
    CreateAccountAndNotifyPartner.call(params, from_fintera)
    NotifyPartner.new("Another").perform
  end
end
