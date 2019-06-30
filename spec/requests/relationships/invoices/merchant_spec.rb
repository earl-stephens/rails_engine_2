require "rails_helper"

RSpec.describe 'invoice', type: :request do
  it "shows invoice to merchant relationships" do
    merchant = Merchant.create!(name: "Kermit")
    item1 = Item.create!(name: "frog", description: "green", unit_price: 2345, merchant_id: merchant.id)
    item2 = Item.create!(name: "pig", description: "pink", unit_price: 3344, merchant_id: merchant.id)
    customer = Customer.create!(first_name: "Jim", last_name: "Henson")
    invoice1 = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant.id)
    invoice2 = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant.id)
    ii1 = InvoiceItem.create!(quantity: 45, unit_price: 100, item_id: item1.id, invoice_id: invoice1.id)
    ii2 = InvoiceItem.create!(quantity: 35, unit_price: 10, item_id: item2.id, invoice_id: invoice2.id)

    get "/api/v1/invoices/#{invoice1.id}/merchant"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["attributes"]["name"]).to eq(merchant.name)
    expect(results["data"]["attributes"]["id"]).to eq(merchant.id)
  end
end
