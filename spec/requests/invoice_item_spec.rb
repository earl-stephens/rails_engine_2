require "rails_helper"

RSpec.describe InvoiceItem, type: :request do
  describe 'index of records' do
    it 'returns a listing of all records' do
      merchant = Merchant.create!(name: "Blondie")
      item = Item.create!(name: "Rapture", description: "Be Pure", unit_price: 1500, merchant_id: merchant.id)
      customer = Customer.create!(first_name: "Debbie", last_name: "Harry")
      invoice = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant.id)
      ii1 = InvoiceItem.create!(quantity: 12, unit_price: 1450, item_id: item.id, invoice_id: invoice.id)
      ii2 = InvoiceItem.create!(quantity: 14, unit_price: 1400, item_id: item.id, invoice_id: invoice.id)
      ii3 = InvoiceItem.create!(quantity: 16, unit_price: 1350, item_id: item.id, invoice_id: invoice.id)

      get "/api/v1/invoice_items"

      results = JSON.parse(response.body)

      expect(response).to be_successful
      expect(results["data"][0]["type"]).to eq("invoice_item")
    end
  end

  describe 'single record' do
    it 'shows a single record' do
      merchant = Merchant.create!(name: "Blondie")
      item = Item.create!(name: "Rapture", description: "Be Pure", unit_price: 1500, merchant_id: merchant.id)
      customer = Customer.create!(first_name: "Debbie", last_name: "Harry")
      invoice = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant.id)
      ii1 = InvoiceItem.create!(quantity: 12, unit_price: 1450, item_id: item.id, invoice_id: invoice.id)
      ii2 = InvoiceItem.create!(quantity: 14, unit_price: 1400, item_id: item.id, invoice_id: invoice.id)
      ii3 = InvoiceItem.create!(quantity: 16, unit_price: 1350, item_id: item.id, invoice_id: invoice.id)

      get "/api/v1/invoice_items/#{ii2.id}"

      results = JSON.parse(response.body)
      # binding.pry

      expect(response).to be_successful
      expect(results["data"]["attributes"]["quantity"]).to eq(ii2.quantity)
    end
  end
end
