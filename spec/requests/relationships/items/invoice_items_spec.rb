require "rails_helper"

RSpec.describe 'items', type: :request do
  it "shows invoice_item to item relationship" do
    merchant1 = Merchant.create!(name: "Kermit")
    merchant2 = Merchant.create!(name: "Fozzy")
    merchant3 = Merchant.create!(name: "Miss Piggy")
    item1 = Item.create!(name: "frog", description: "green", unit_price: 2345, merchant_id: merchant1.id)
    item2 = Item.create!(name: "bear", description: "brown", unit_price: 3344, merchant_id: merchant2.id)
    item3 = Item.create!(name: "pig", description: "pink", unit_price: 3344, merchant_id: merchant3.id)
    customer1 = Customer.create!(first_name: "Jim", last_name: "Henson")
    invoice1 = Invoice.create!(status: "shipped", customer_id: customer1.id, merchant_id: merchant1.id)
    invoice2 = Invoice.create!(status: "shipped", customer_id: customer1.id, merchant_id: merchant2.id)
    invoice3 = Invoice.create!(status: "shipped", customer_id: customer1.id, merchant_id: merchant3.id)
    invoice4 = Invoice.create!(status: "shipped", customer_id: customer1.id, merchant_id: merchant1.id)
    invoice5 = Invoice.create!(status: "shipped", customer_id: customer1.id, merchant_id: merchant2.id)
    invoice6 = Invoice.create!(status: "shipped", customer_id: customer1.id, merchant_id: merchant3.id)
    ii1 = InvoiceItem.create!(quantity: 45, unit_price: 100, item_id: item1.id, invoice_id: invoice1.id)
    ii2 = InvoiceItem.create!(quantity: 35, unit_price: 10, item_id: item2.id, invoice_id: invoice2.id)
    ii3 = InvoiceItem.create!(quantity: 30, unit_price: 50, item_id: item1.id, invoice_id: invoice3.id)
    ii3 = InvoiceItem.create!(quantity: 20, unit_price: 12, item_id: item1.id, invoice_id: invoice4.id)
    ii3 = InvoiceItem.create!(quantity: 300, unit_price: 16, item_id: item2.id, invoice_id: invoice5.id)
    ii3 = InvoiceItem.create!(quantity: 85, unit_price: 48, item_id: item3.id, invoice_id: invoice6.id)

    get "/api/v1/items/#{item1.id}/invoice_items"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"].count).to eq(3)
    expect(results["data"][1]["attributes"]["quantity"]).to eq(30)
    expect(results["data"][2]["attributes"]["unit_price"]).to eq("0.12")
  end
end
