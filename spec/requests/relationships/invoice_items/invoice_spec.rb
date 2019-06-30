require "rails_helper"

RSpec.describe 'invoice items', type: :request do
  it "shows invoice to invoice_item relationship" do
    merchant1 = Merchant.create!(name: "Kermit")
    item1 = Item.create!(name: "frog", description: "green", unit_price: 2345, merchant_id: merchant1.id)
    item2 = Item.create!(name: "bear", description: "brown", unit_price: 3344, merchant_id: merchant1.id)
    item3 = Item.create!(name: "pig", description: "pink", unit_price: 3344, merchant_id: merchant1.id)
    customer1 = Customer.create!(first_name: "Jim", last_name: "Henson")
    invoice1 = Invoice.create!(status: "shipped", customer_id: customer1.id, merchant_id: merchant1.id)
    invoice2 = Invoice.create!(status: "shipped", customer_id: customer1.id, merchant_id: merchant1.id)
    ii1 = InvoiceItem.create!(quantity: 45, unit_price: 100, item_id: item1.id, invoice_id: invoice1.id)
    ii2 = InvoiceItem.create!(quantity: 25, unit_price: 10, item_id: item2.id, invoice_id: invoice2.id)

    get "/api/v1/invoice_items/#{ii1.id}/invoice"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    # expect(results["data"].count).to eq(3)
    expect(results["data"]["attributes"]["status"]).to eq(invoice1.status)
    expect(results["data"]["attributes"]["id"]).to eq(invoice1.id)
    expect(results["data"]["attributes"]["customer_id"]).to eq(customer1.id)
  end
end
