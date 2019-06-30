require "rails_helper"

RSpec.describe 'items', type: :request do
  it "shows item to merchant relationships" do
    merchant1 = Merchant.create!(name: "Kermit")
    merchant2 = Merchant.create!(name: "Fozzy")
    item1 = Item.create!(name: "frog", description: "green", unit_price: 2345, merchant_id: merchant1.id)
    item2 = Item.create!(name: "bear", description: "brown", unit_price: 3344, merchant_id: merchant1.id)
    item3 = Item.create!(name: "pig", description: "pink", unit_price: 3344, merchant_id: merchant2.id)
    item4 = Item.create!(name: "animal", description: "red", unit_price: 4512, merchant_id: merchant1.id)

    get "/api/v1/items/#{item4.id}/merchant"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["attributes"]["name"]).to eq(merchant1.name)
    expect(results["data"]["attributes"]["id"]).to eq(merchant1.id)
  end
end
