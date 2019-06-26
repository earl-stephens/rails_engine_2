require "rails_helper"

RSpec.describe Transaction, type: :request do
  describe 'index of records' do
    it 'returns a listing of all records' do
      customer = Customer.create!(first_name: "Chrissy", last_name: "Hind")
      merchant = Merchant.create!(name: "The Pretenders")
      invoice = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant.id)
      transaction1 = Transaction.create!(credit_card_number: 1234, result: "success", invoice_id: invoice.id)
      transaction2 = Transaction.create!(credit_card_number: 2345, result: "pending", invoice_id: invoice.id)
      transaction3 = Transaction.create!(credit_card_number: 3456, result: "failed", invoice_id: invoice.id)

      get '/api/v1/transactions'

      results = JSON.parse(response.body)

      expect(response).to be_successful
      expect(results["data"][0]["type"]).to eq("transaction")
    end
  end

  describe 'single record' do
    it 'shows a single record' do
      customer = Customer.create!(first_name: "Chrissy", last_name: "Hind")
      merchant = Merchant.create!(name: "The Pretenders")
      invoice = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant.id)
      transaction1 = Transaction.create!(credit_card_number: 1234, result: "success", invoice_id: invoice.id)
      transaction2 = Transaction.create!(credit_card_number: 2345, result: "pending", invoice_id: invoice.id)
      transaction3 = Transaction.create!(credit_card_number: 3456, result: "failed", invoice_id: invoice.id)

      get "/api/v1/transactions/#{transaction3.id}"

      results = JSON.parse(response.body)

      expect(response).to be_successful
      expect(results["data"]["attributes"]["result"]).to eq(transaction3.result)
    end
  end
end
