class NotifyPartner
  def initialize(partner = "internal", message = "new registration")
    @partner = partner
    @message = message
  end

  def perform
    url = "https://61b69749c95dd70017d40f4b.mockapi.io/awesome_partner_leads"
    Faraday.post(url, { partner: @partner, message: @message })
  end
end
