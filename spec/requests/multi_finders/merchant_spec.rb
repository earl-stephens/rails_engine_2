require "rails_helper"

RSpec.describe 'merchant multi finder', type: :request do
  before :each do
    @merchant1 = Merchant.create!(name: "Bugs Bunny",
                        created_at: "2019-06-29T14:54:05.000Z",
                        updated_at: "2019-06-30T14:54:05.000Z")
    @merchant2 = Merchant.create!(name: "Elmer Fudd",
                        created_at: "2019-06-29T14:54:05.000Z",
                        updated_at: "2019-06-30T14:54:05.000Z")
    @merchant3 = Merchant.create!(name: "Daffy Duck",
                        created_at: "2018-06-29T14:54:05.000Z",
                        updated_at: "2018-06-30T14:54:05.000Z")
  end

  it "gets merchants by id" do
    get "/api/v1/merchants/find_all?id=#{@merchant2.id}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"][0]["id"]).to eq("#{@merchant2.id}")
    expect(results["data"][0]["attributes"]["name"]).to eq(@merchant2.name)
  end

  it "gets merchants by name" do
    get "/api/v1/merchants/find_all?name=#{@merchant1.name}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"][0]["id"]).to eq("#{@merchant1.id}")
    expect(results["data"][0]["attributes"]["name"]).to eq(@merchant1.name)
  end
end
