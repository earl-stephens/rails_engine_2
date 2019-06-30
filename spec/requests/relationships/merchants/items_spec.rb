require "rails_helper"

RSpec.describe 'merchant', type: :request do
  it "shows merchant to item relationships" do
    merchant1 = Merchant.create!(name: "Kermit")
    merchant2 = Merchant.create!(name: "Fozzy")
    item1 = Item.create!(name: "frog", description: "green", unit_price: 2345, merchant_id: merchant1.id)
    item2 = Item.create!(name: "bear", description: "brown", unit_price: 3344, merchant_id: merchant1.id)
    item3 = Item.create!(name: "pig", description: "pink", unit_price: 3344, merchant_id: merchant2.id)

    get "/api/v1/merchants/#{merchant1.id}/items"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"].count).to eq(2)
    expect(results["data"][0]["type"]).to eq("item")
    expect(results["data"][1]["attributes"]["merchant_id"]).to eq(merchant1.id)
  end
end
