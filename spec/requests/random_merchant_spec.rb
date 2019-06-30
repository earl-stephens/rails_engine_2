require "rails_helper"

RSpec.describe 'random', type: :request do
  it "can return a random merchant" do
    merchant1 = Merchant.create!(name: "Kermit")
    merchant2 = Merchant.create!(name: "Fozzy")
    merchant3 = Merchant.create!(name: "Miss Piggy")
    merchant4 = Merchant.create!(name: "Statler")
    merchant5 = Merchant.create!(name: "Waldorf")

    get '/api/v1/merchants/random'

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["type"]).to eq("merchant")
    expect(results["data"]["attributes"]).to have_key("name")
  end
end
