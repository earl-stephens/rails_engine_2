require "rails_helper"

RSpec.describe 'customer single finders', type: :request do
  before :each do
    @customer1 = Customer.create!(first_name: "Paul",
                                  last_name: "McCartney",
                                  created_at: "2012-03-27T14:54:05.000Z",
                                  updated_at: "2012-03-27T14:54:05.000Z")
  end

  it "finds customer by id" do
    get "/api/v1/customers/find?id=#{@customer1.id}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@customer1.id}")
    expect(results["data"]["attributes"]["first_name"]).to eq(@customer1.first_name)
    expect(results["data"]["attributes"]["last_name"]).to eq(@customer1.last_name)
  end

  it "finds customer by first_name" do
    get "/api/v1/customers/find?first_name=#{@customer1.first_name}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@customer1.id}")
    expect(results["data"]["attributes"]["first_name"]).to eq(@customer1.first_name)
    expect(results["data"]["attributes"]["last_name"]).to eq(@customer1.last_name)
  end

  it "finds customer by last_name" do
    get "/api/v1/customers/find?last_name=#{@customer1.last_name}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@customer1.id}")
    expect(results["data"]["attributes"]["first_name"]).to eq(@customer1.first_name)
    expect(results["data"]["attributes"]["last_name"]).to eq(@customer1.last_name)
  end

  it "finds customer by created_at" do
    get "/api/v1/customers/find?created_at=#{@customer1.created_at}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@customer1.id}")
    expect(results["data"]["attributes"]["first_name"]).to eq(@customer1.first_name)
    expect(results["data"]["attributes"]["last_name"]).to eq(@customer1.last_name)
  end

  it "finds customer by updated_at" do
    get "/api/v1/customers/find?updated_at=#{@customer1.updated_at}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@customer1.id}")
    expect(results["data"]["attributes"]["first_name"]).to eq(@customer1.first_name)
    expect(results["data"]["attributes"]["last_name"]).to eq(@customer1.last_name)
  end
end
