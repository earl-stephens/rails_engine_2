require "rails_helper"

RSpec.describe 'customer multi finder', type: :request do
  before :each do
    @customer1 = Customer.create!(first_name: "Paul",
                                  last_name: "McCartney",
                                  created_at: "2012-03-27T14:54:05.000Z",
                                  updated_at: "2012-03-27T14:54:05.000Z")
    @customer2 = Customer.create!(first_name: "Paul",
                                  last_name: "Starr",
                                  created_at: "2012-03-27T14:54:05.000Z",
                                  updated_at: "2012-03-27T14:54:05.000Z")
    @customer3 = Customer.create!(first_name: "Ringo",
                                  last_name: "Starr",
                                  created_at: "2011-03-27T14:54:05.000Z",
                                  updated_at: "2011-03-27T14:54:05.000Z")
  end

  it "finds customer by id" do
    get "/api/v1/customers/find_all?id=#{@customer1.id}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"].count).to eq(1)
    expect(results["data"][0]["id"]).to eq("#{@customer1.id}")
    expect(results["data"][0]["attributes"]["first_name"]).to eq(@customer1.first_name)
    expect(results["data"][0]["attributes"]["last_name"]).to eq(@customer1.last_name)
  end

  it "finds customer by first_name" do
    get "/api/v1/customers/find_all?first_name=#{@customer1.first_name}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"].count).to eq(2)
    expect(results["data"][0]["id"]).to eq("#{@customer1.id}")
    expect(results["data"][0]["attributes"]["first_name"]).to eq(@customer1.first_name)
    expect(results["data"][1]["attributes"]["last_name"]).to eq(@customer2.last_name)
  end

  it "finds customer by last_name" do
    get "/api/v1/customers/find_all?last_name=#{@customer2.last_name}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"].count).to eq(2)
    expect(results["data"][0]["id"]).to eq("#{@customer2.id}")
    expect(results["data"][0]["attributes"]["first_name"]).to eq(@customer2.first_name)
    expect(results["data"][1]["attributes"]["last_name"]).to eq(@customer3.last_name)
  end
end
