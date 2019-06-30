require "rails_helper"

RSpec.describe 'invoices', type: :request do
  it "shows invoice_items to invoice relationship" do
    merchant1 = Merchant.create!(name: "Kermit")
    item1 = Item.create!(name: "frog", description: "green", unit_price: 2345, merchant_id: merchant1.id)
    item2 = Item.create!(name: "bear", description: "brown", unit_price: 3344, merchant_id: merchant1.id)
    customer1 = Customer.create!(first_name: "Jim", last_name: "Henson")
    invoice1 = Invoice.create!(status: "shipped", customer_id: customer1.id, merchant_id: merchant1.id)
    invoice2 = Invoice.create!(status: "shipped", customer_id: customer1.id, merchant_id: merchant1.id)
    ii1 = InvoiceItem.create!(quantity: 45, unit_price: 100, item_id: item1.id, invoice_id: invoice1.id)
    ii2 = InvoiceItem.create!(quantity: 25, unit_price: 10, item_id: item2.id, invoice_id: invoice2.id)
    ii3 = InvoiceItem.create!(quantity: 2, unit_price: 44, item_id: item2.id, invoice_id: invoice1.id)

    get "/api/v1/invoices/#{invoice1.id}/invoice_items"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"].count).to eq(2)
    expect(results["data"][0]["attributes"]["quantity"]).to eq(ii1.quantity)
    expect(results["data"][0]["attributes"]["id"]).to eq(ii1.id)
    expect(results["data"][1]["attributes"]["unit_price"]).to eq("0.44")
  end
end
