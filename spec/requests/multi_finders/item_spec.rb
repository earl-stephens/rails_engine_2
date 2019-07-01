require "rails_helper"

RSpec.describe 'item multi finders', type: :request do
  before :each do
    merchant = Merchant.create!(name: "Wile E. Coyote")
    @item1 = Item.create!(name: "frog",
                        description: "green",
                        unit_price: 123,
                        merchant_id: merchant.id,
                        created_at: "2012-03-27T14:54:05.000Z",
                        updated_at: "2012-03-27T14:54:05.000Z")
    @item2 = Item.create!(name: "frog",
                        description: "pink",
                        unit_price: 234,
                        merchant_id: merchant.id,
                        created_at: "2012-03-27T14:54:05.000Z",
                        updated_at: "2012-03-27T14:54:05.000Z")
    @item3 = Item.create!(name: "bear",
                        description: "pink",
                        unit_price: 234,
                        merchant_id: merchant.id,
                        created_at: "2011-03-27T14:54:05.000Z",
                        updated_at: "2011-03-27T14:54:05.000Z")
  end

  it "finds items by id" do
    get "/api/v1/items/find_all?id=#{@item1.id}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"][0]["id"]).to eq("#{@item1.id}")
    expect(results["data"][0]["attributes"]["description"]).to eq(@item1.description)
    expect(results["data"][0]["attributes"]["unit_price"]).to eq("1.23")
    expect(results["data"][0]["attributes"]["merchant_id"]).to eq(@item1.merchant_id)
  end

  it "finds items by name" do
    get "/api/v1/items/find_all?name=#{@item1.name}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"].count).to eq(2)
    expect(results["data"][0]["id"]).to eq("#{@item1.id}")
    expect(results["data"][0]["attributes"]["description"]).to eq(@item1.description)
    expect(results["data"][1]["attributes"]["unit_price"]).to eq("2.34")
    expect(results["data"][1]["attributes"]["merchant_id"]).to eq(@item2.merchant_id)
  end

  it "finds items by description" do
    get "/api/v1/items/find_all?description=#{@item2.description}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"].count).to eq(2)
    expect(results["data"][0]["id"]).to eq("#{@item2.id}")
    expect(results["data"][0]["attributes"]["description"]).to eq(@item2.description)
    expect(results["data"][1]["attributes"]["unit_price"]).to eq("2.34")
    expect(results["data"][1]["attributes"]["merchant_id"]).to eq(@item3.merchant_id)
  end

  it "finds items by unit_price" do
    get "/api/v1/items/find_all?unit_price=2.34"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"].count).to eq(2)
    expect(results["data"][0]["id"]).to eq("#{@item2.id}")
    expect(results["data"][0]["attributes"]["description"]).to eq(@item2.description)
    expect(results["data"][1]["attributes"]["unit_price"]).to eq("2.34")
    expect(results["data"][1]["attributes"]["merchant_id"]).to eq(@item3.merchant_id)
  end

  it "finds items by merchant_id" do
    get "/api/v1/items/find_all?merchant_id=#{@item1.merchant_id}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"].count).to eq(3)
    expect(results["data"][2]["id"]).to eq("#{@item3.id}")
    expect(results["data"][1]["attributes"]["description"]).to eq(@item2.description)
    expect(results["data"][1]["attributes"]["unit_price"]).to eq("2.34")
    expect(results["data"][2]["attributes"]["merchant_id"]).to eq(@item3.merchant_id)
  end
end
