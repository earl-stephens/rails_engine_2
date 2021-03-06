require "rails_helper"

RSpec.describe 'item single finder', type: :request do
  before :each do
    merchant = Merchant.create!(name: "Wile E. Coyote")
    @item = Item.create!(name: "frog",
                        description: "green",
                        unit_price: 123,
                        merchant_id: merchant.id,
                        created_at: "2012-03-27T14:54:05.000Z",
                        updated_at: "2012-03-27T14:54:05.000Z")
  end

  it "finds an item by id" do
    get "/api/v1/items/find?id=#{@item.id}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@item.id}")
    expect(results["data"]["attributes"]["description"]).to eq(@item.description)
    expect(results["data"]["attributes"]["unit_price"]).to eq("1.23")
    expect(results["data"]["attributes"]["merchant_id"]).to eq(@item.merchant_id)
  end

  it "finds an item by name" do
    get "/api/v1/items/find?name=#{@item.name}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@item.id}")
    expect(results["data"]["attributes"]["description"]).to eq(@item.description)
    expect(results["data"]["attributes"]["unit_price"]).to eq("1.23")
    expect(results["data"]["attributes"]["merchant_id"]).to eq(@item.merchant_id)
  end

  it "finds an item by unit_price" do
    get "/api/v1/items/find?unit_price=#{@item.unit_price}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@item.id}")
    expect(results["data"]["attributes"]["description"]).to eq(@item.description)
    expect(results["data"]["attributes"]["unit_price"]).to eq("1.23")
    expect(results["data"]["attributes"]["merchant_id"]).to eq(@item.merchant_id)
  end

  it "finds an item by description" do
    get "/api/v1/items/find?description=#{@item.description}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@item.id}")
    expect(results["data"]["attributes"]["description"]).to eq(@item.description)
    expect(results["data"]["attributes"]["unit_price"]).to eq("1.23")
    expect(results["data"]["attributes"]["merchant_id"]).to eq(@item.merchant_id)
  end

  it "finds an item by merchant_id" do
    get "/api/v1/items/find?merchant_id=#{@item.merchant_id}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@item.id}")
    expect(results["data"]["attributes"]["description"]).to eq(@item.description)
    expect(results["data"]["attributes"]["unit_price"]).to eq("1.23")
    expect(results["data"]["attributes"]["merchant_id"]).to eq(@item.merchant_id)
  end

  it "finds an item by created_at" do
    get "/api/v1/items/find?created_at=#{@item.created_at}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@item.id}")
    expect(results["data"]["attributes"]["description"]).to eq(@item.description)
    expect(results["data"]["attributes"]["unit_price"]).to eq("1.23")
    expect(results["data"]["attributes"]["merchant_id"]).to eq(@item.merchant_id)
  end

  it "finds an item by updated_at" do
    get "/api/v1/items/find?updated_at=#{@item.updated_at}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@item.id}")
    expect(results["data"]["attributes"]["description"]).to eq(@item.description)
    expect(results["data"]["attributes"]["unit_price"]).to eq("1.23")
    expect(results["data"]["attributes"]["merchant_id"]).to eq(@item.merchant_id)
  end
end
