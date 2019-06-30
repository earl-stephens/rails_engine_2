require "rails_helper"

RSpec.describe 'invoice', type: :request do
  it "shows invoice to customer relationship" do
    merchant1 = Merchant.create!(name: "Kermit")
    item1 = Item.create!(name: "frog", description: "green", unit_price: 2345, merchant_id: merchant1.id)
    item2 = Item.create!(name: "bear", description: "brown", unit_price: 3344, merchant_id: merchant1.id)
    item3 = Item.create!(name: "pig", description: "pink", unit_price: 3344, merchant_id: merchant1.id)
    customer1 = Customer.create!(first_name: "Jim", last_name: "Henson")
    customer2 = Customer.create!(first_name: "Frank", last_name: "Oz")
    invoice1 = Invoice.create!(status: "shipped", customer_id: customer1.id, merchant_id: merchant1.id)
    invoice2 = Invoice.create!(status: "shipped", customer_id: customer1.id, merchant_id: merchant1.id)
    invoice3 = Invoice.create!(status: "shipped", customer_id: customer2.id, merchant_id: merchant1.id)

    get "/api/v1/invoices/#{invoice1.id}/customer"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["attributes"]["id"]).to eq(customer1.id)
    expect(results["data"]["attributes"]["first_name"]).to eq(customer1.first_name)
    expect(results["data"]["attributes"]["last_name"]).to eq(customer1.last_name)
  end
end
