require "rails_helper"

RSpec.describe Merchant, type: :request do
  describe 'index of records' do
    it 'returns a listing of all records' do
      merch1 = Merchant.create!(name: "Raul")
      merch2 = Merchant.create!(name: "Jorge")
      merch3 = Merchant.create!(name: "Ricardo")
      get '/api/v1/merchants'

      results = JSON.parse(response.body)
# binding.pry
      expect(response).to be_successful
      expect(results["data"][0]["type"]).to eq("merchant")
    end
  end

  describe 'single record' do
    it 'shows a single record' do
      merch1 = Merchant.create!(name: "Raul")
      merch2 = Merchant.create!(name: "Jorge")
      merch3 = Merchant.create!(name: "Ricardo")
      get "/api/v1/merchants/#{merch2.id}"

      # binding.pry
      results = JSON.parse(response.body)
      expect(response).to be_successful
      expect(results["data"]["type"]).to eq("merchant")
      expect(results["data"]["attributes"]["name"]).to eq(merch2.name)
    end
  end
end
