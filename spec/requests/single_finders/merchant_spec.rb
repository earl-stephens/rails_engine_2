require "rails_helper"

RSpec.describe 'merchant single finders', type: :request do
  before :each do
    @merchant1 = Merchant.create!(name: "Bugs Bunny",
                        created_at: "2019-06-29T14:54:05.000Z",
                        updated_at: "2019-06-30T14:54:05.000Z")
  end

  it "finds merchant by id" do
    get "/api/v1/merchants/find?id=#{@merchant1.id}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@merchant1.id}")
    expect(results["data"]["attributes"]["name"]).to eq(@merchant1.name)
  end

  it "finds merchant by name" do
    get "/api/v1/merchants/find?name=#{@merchant1.name}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@merchant1.id}")
    expect(results["data"]["attributes"]["name"]).to eq(@merchant1.name)
  end

  it "finds merchant by created at date" do
    get "/api/v1/merchants/find?created_at=#{@merchant1.created_at}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@merchant1.id}")
    expect(results["data"]["attributes"]["name"]).to eq(@merchant1.name)
  end

  it "finds merchant by updated at" do
    get "/api/v1/merchants/find?updated_at=#{@merchant1.updated_at}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@merchant1.id}")
    expect(results["data"]["attributes"]["name"]).to eq(@merchant1.name)
  end
end
