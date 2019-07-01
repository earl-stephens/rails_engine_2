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
end
