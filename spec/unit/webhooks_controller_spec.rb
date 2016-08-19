require 'rails_helper'

describe WebhooksController, 'testing routes' do

  def response_hash
    {"emails_sent" => 2,
     "emails_opened"=> 1,
     "emails_clicked"=> 1,
     "open_rate"=> {"Shipment" => 1.0, "UserConfirmation" => 0.0},
     "click_rate"=> {"Shipment" => 0.0, "UserConfirmation" => 1.0}}
  end

  before(:each) do
    create_data
  end


  describe '#index' do
    it 'shows all webhooks in the database', type: :request do
      get '/'
      json = JSON.parse(response.body)
      expect(json).to eq(response_hash)
    end
  end

  describe '#create' do
    it 'allows a new record to be posted to the database', type: :request do
      request = {address:"test@lostmy.name",email_type:"GetABookDiscount",event:"send",timestamp:"1432820696"}
      post '/webhooks', webhook:request
      expect(Webhook.last.email_type).to eq("GetABookDiscount")
    end
  end
end
