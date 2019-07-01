require "rails_helper"

RSpec.describe 'invoice single finders', type: :request do
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
  end

  it "finds invoice by id" do
    get "/api/v1/invoices/find?id=#{@invoice1.id}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@invoice1.id}")
    expect(results["data"]["attributes"]["status"]).to eq(@invoice1.status)
    expect(results["data"]["attributes"]["customer_id"]).to eq(@invoice1.customer_id)
    expect(results["data"]["attributes"]["merchant_id"]).to eq(@invoice1.merchant_id)
  end

  it "finds invoice by customer_id" do
    get "/api/v1/invoices/find?customer_id=#{@invoice1.customer_id}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@invoice1.id}")
    expect(results["data"]["attributes"]["status"]).to eq(@invoice1.status)
    expect(results["data"]["attributes"]["customer_id"]).to eq(@invoice1.customer_id)
    expect(results["data"]["attributes"]["merchant_id"]).to eq(@invoice1.merchant_id)
  end

  it "finds invoice by merchant_id" do
    get "/api/v1/invoices/find?merchant_id=#{@invoice1.merchant_id}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@invoice1.id}")
    expect(results["data"]["attributes"]["status"]).to eq(@invoice1.status)
    expect(results["data"]["attributes"]["customer_id"]).to eq(@invoice1.customer_id)
    expect(results["data"]["attributes"]["merchant_id"]).to eq(@invoice1.merchant_id)
  end

  it "finds invoice by status" do
    get "/api/v1/invoices/find?status=#{@invoice1.status}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@invoice1.id}")
    expect(results["data"]["attributes"]["status"]).to eq(@invoice1.status)
    expect(results["data"]["attributes"]["customer_id"]).to eq(@invoice1.customer_id)
    expect(results["data"]["attributes"]["merchant_id"]).to eq(@invoice1.merchant_id)
  end
end
