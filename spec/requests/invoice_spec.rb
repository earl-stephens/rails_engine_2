require "rails_helper"

RSpec.describe Invoice, type: :request do
  describe 'index of records' do
    it 'returns a listing of all records' do
      customer = Customer.create!(first_name: "Robert", last_name: "Plant")
      merchant = Merchant.create!(name: "Led Zeppelin")
      invoice1 = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant.id)
      invoice2 = Invoice.create!(status: "delayed", customer_id: customer.id, merchant_id: merchant.id)
      invoice3 = Invoice.create!(status: "cancelled", customer_id: customer.id, merchant_id: merchant.id)

      get '/api/v1/invoices'

      results = JSON.parse(response.body)

      expect(response).to be_successful
      expect(results["data"][0]["type"]).to eq("invoice")
    end
  end

  describe 'single record' do
    it 'shows a single record' do
      customer = Customer.create!(first_name: "Robert", last_name: "Plant")
      merchant = Merchant.create!(name: "Led Zeppelin")
      invoice1 = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant.id)
      invoice2 = Invoice.create!(status: "delayed", customer_id: customer.id, merchant_id: merchant.id)
      invoice3 = Invoice.create!(status: "cancelled", customer_id: customer.id, merchant_id: merchant.id)

      get "/api/v1/invoices/#{invoice3.id}"

      results = JSON.parse(response.body)

      expect(response).to be_successful
      expect(results["data"]["attributes"]["status"]).to eq(invoice3.status)
    end
  end
end
