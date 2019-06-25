require "rails_helper"

RSpec.describe Item, type: :request do
  describe 'index of records' do
    it 'shows a listing of all records' do
      merch1 = Merchant.create!(name: "Dunkin Donuts")
      item1 = Item.create!(name: "muffin", description: "blueberry", unit_price: 1234, merchant_id: merch1.id)
      item2 = Item.create!(name: "donut", description: "glazed", unit_price: 2345, merchant_id: merch1.id)
      item3 = Item.create!(name: "scone", description: "raspberry", unit_price: 3456, merchant_id: merch1.id)

      get '/api/v1/items'

      results = JSON.parse(response.body)

      expect(response).to be_successful
      expect(results["data"][0]["type"]).to eq("item")
    end
  end

  describe 'single record' do
    it 'shows a single record' do
      merch1 = Merchant.create!(name: "Dunkin Donuts")
      item1 = Item.create!(name: "muffin", description: "blueberry", unit_price: 1234, merchant_id: merch1.id)
      item2 = Item.create!(name: "donut", description: "glazed", unit_price: 2345, merchant_id: merch1.id)
      item3 = Item.create!(name: "scone", description: "raspberry", unit_price: 3456, merchant_id: merch1.id)

      get "/api/v1/items/#{item3.id}"

      results = JSON.parse(response.body)

      expect(response).to be_successful
      expect(results["data"]["attributes"]["name"]).to eq(item3.name)
    end
  end
end
