require "rails_helper"

RSpec.describe "Revenue", type: :request do
  describe 'single merchant' do
    it 'gets total revenue for that merchant' do
      merchant = Merchant.create!(name: "Kermit")
      item1 = Item.create!(name: "frog", description: "green", unit_price: 2345, merchant_id: merchant.id)
      item2 = Item.create!(name: "pig", description: "pink", unit_price: 3344, merchant_id: merchant.id)
      customer = Customer.create!(first_name: "Jim", last_name: "Henson")
      invoice1 = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant.id)
      invoice2 = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant.id)
      ii1 = InvoiceItem.create!(quantity: 45, unit_price: 100, item_id: item1.id, invoice_id: invoice1.id)
      ii2 = InvoiceItem.create!(quantity: 35, unit_price: 10, item_id: item2.id, invoice_id: invoice1.id)
      ii3 = InvoiceItem.create!(quantity: 30, unit_price: 50, item_id: item1.id, invoice_id: invoice2.id)
      transaction1 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice1.id)
      transaction2 = Transaction.create!(credit_card_number: "9876", result: "failed", invoice_id: invoice2.id)
      # transaction3 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice2.id)

      get "/api/v1/merchants/#{merchant.id}/revenue"

      results = JSON.parse(response.body)

      expect(response).to be_successful
      expect(results["data"]["attributes"]["revenue"]).to eq("48.50")
    end

    it 'gets best customer' do
      merchant = Merchant.create!(name: "Kermit")
      item1 = Item.create!(name: "frog", description: "green", unit_price: 2345, merchant_id: merchant.id)
      item2 = Item.create!(name: "pig", description: "pink", unit_price: 3344, merchant_id: merchant.id)
      customer1 = Customer.create!(first_name: "Jim", last_name: "Henson")
      customer2 = Customer.create!(first_name: "Frank", last_name: "Oz")
      customer3 = Customer.create!(first_name: "Jeff", last_name: "Dunham")
      invoice1 = Invoice.create!(status: "shipped", customer_id: customer1.id, merchant_id: merchant.id)
      invoice2 = Invoice.create!(status: "shipped", customer_id: customer2.id, merchant_id: merchant.id)
      invoice3 = Invoice.create!(status: "shipped", customer_id: customer2.id, merchant_id: merchant.id)
      invoice4 = Invoice.create!(status: "shipped", customer_id: customer3.id, merchant_id: merchant.id)
      invoice5 = Invoice.create!(status: "shipped", customer_id: customer3.id, merchant_id: merchant.id)
      invoice6 = Invoice.create!(status: "shipped", customer_id: customer3.id, merchant_id: merchant.id)
      ii1 = InvoiceItem.create!(quantity: 45, unit_price: 100, item_id: item1.id, invoice_id: invoice1.id)
      ii2 = InvoiceItem.create!(quantity: 35, unit_price: 10, item_id: item2.id, invoice_id: invoice1.id)
      ii3 = InvoiceItem.create!(quantity: 30, unit_price: 50, item_id: item1.id, invoice_id: invoice2.id)
      transaction1 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice1.id)
      transaction2 = Transaction.create!(credit_card_number: "9876", result: "failed", invoice_id: invoice2.id)
      transaction3 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice3.id)
      transaction4 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice4.id)
      transaction5 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice5.id)
      transaction6 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice6.id)

      get "/api/v1/merchants/#{merchant.id}/favorite_customer"

      results = JSON.parse(response.body)

      expect(response).to be_successful
      expect(results["data"]["attributes"]["id"]).to eq(customer3.id)
    end
  end
end
