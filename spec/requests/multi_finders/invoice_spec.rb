require "rails_helper"

RSpec.describe 'invoice multi finders', type: :request do
  before :each do
    customer = Customer.create!(first_name: "Tasmanian", last_name: "Devil")
    merchant = Merchant.create!(name: "Wile E. Coyote")
    @invoice1 = Invoice.create!(
      status: "shipped",
      customer_id: customer.id,
      merchant_id: merchant.id,
      created_at: "2012-03-27T14:54:05.000Z",
      updated_at: "2012-03-27T14:54:05.000Z"
    )
    @invoice2 = Invoice.create!(
      status: "shipped",
      customer_id: customer.id,
      merchant_id: merchant.id,
      created_at: "2012-03-27T14:54:05.000Z",
      updated_at: "2012-03-27T14:54:05.000Z"
    )
    @invoice3 = Invoice.create!(
      status: "shipped",
      customer_id: customer.id,
      merchant_id: merchant.id,
      created_at: "2011-03-27T14:54:05.000Z",
      updated_at: "2011-03-27T14:54:05.000Z"
    )
  end

  it "finds invoices by id" do
    get "/api/v1/invoices/find_all?id=#{@invoice2.id}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"][0]["id"]).to eq("#{@invoice2.id}")
    expect(results["data"][0]["attributes"]["status"]).to eq(@invoice2.status)
    expect(results["data"][0]["attributes"]["customer_id"]).to eq(@invoice2.customer_id)
    expect(results["data"][0]["attributes"]["merchant_id"]).to eq(@invoice2.merchant_id)
  end

  it "finds invoices by customer_id" do
    get "/api/v1/invoices/find_all?customer_id=#{@invoice2.customer_id}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"].count).to eq(3)
    expect(results["data"][0]["id"]).to eq("#{@invoice1.id}")
    expect(results["data"][0]["attributes"]["status"]).to eq(@invoice1.status)
    expect(results["data"][1]["attributes"]["customer_id"]).to eq(@invoice2.customer_id)
    expect(results["data"][2]["attributes"]["merchant_id"]).to eq(@invoice3.merchant_id)
  end

  it "finds invoices by merchant_id" do
    get "/api/v1/invoices/find_all?merchant_id=#{@invoice2.merchant_id}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"].count).to eq(3)
    expect(results["data"][0]["id"]).to eq("#{@invoice1.id}")
    expect(results["data"][0]["attributes"]["status"]).to eq(@invoice1.status)
    expect(results["data"][1]["attributes"]["customer_id"]).to eq(@invoice2.customer_id)
    expect(results["data"][2]["attributes"]["merchant_id"]).to eq(@invoice3.merchant_id)
  end

  it "finds invoices by status" do
    get "/api/v1/invoices/find_all?status=#{@invoice3.status}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"].count).to eq(3)
    expect(results["data"][1]["id"]).to eq("#{@invoice2.id}")
    expect(results["data"][0]["attributes"]["status"]).to eq(@invoice1.status)
    expect(results["data"][0]["attributes"]["customer_id"]).to eq(@invoice1.customer_id)
    expect(results["data"][2]["attributes"]["merchant_id"]).to eq(@invoice3.merchant_id)
  end

  it "finds invoices by created_at" do
    get "/api/v1/invoices/find_all?created_at=#{@invoice2.created_at}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"].count).to eq(2)
    expect(results["data"][1]["id"]).to eq("#{@invoice2.id}")
    expect(results["data"][0]["attributes"]["status"]).to eq(@invoice1.status)
    expect(results["data"][0]["attributes"]["customer_id"]).to eq(@invoice1.customer_id)
    expect(results["data"][1]["attributes"]["merchant_id"]).to eq(@invoice2.merchant_id)
  end
end
