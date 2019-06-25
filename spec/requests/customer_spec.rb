require "rails_helper"

RSpec.describe Customer, type: :request do
  describe 'index of records' do
    it 'returns a listing of all records' do
      customer1 = Customer.create!(first_name: "Paul", last_name: "McCartney")
      customer2 = Customer.create!(first_name: "Ringo", last_name: "Starr")
      customer3 = Customer.create!(first_name: "John", last_name: "Lennon")

      get '/api/v1/customers'

      results = JSON.parse(response.body)

      expect(response).to be_successful
      expect(results["data"][0]["type"]).to eq("customer")
    end
  end

  describe 'single record' do
    it 'shows a single record' do
      customer1 = Customer.create!(first_name: "Paul", last_name: "McCartney")
      customer2 = Customer.create!(first_name: "Ringo", last_name: "Starr")
      customer3 = Customer.create!(first_name: "John", last_name: "Lennon")

      get "/api/v1/customers/#{customer2.id}"

      results = JSON.parse(response.body)

      expect(response).to be_successful
      expect(results["data"]["type"]).to eq("customer")
      expect(results["data"]["attributes"]["first_name"]).to eq(customer2.first_name)
    end
  end
end
