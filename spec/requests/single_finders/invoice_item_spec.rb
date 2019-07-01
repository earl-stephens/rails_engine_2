require "rails_helper"

RSpec.describe 'invoice item single finder', type: :request do
  before :each do
    customer = Customer.create!(first_name: "Tasmanian", last_name: "Devil")
    merchant = Merchant.create!(name: "Wile E. Coyote")
    invoice1 = Invoice.create!(
      status: "shipped",
      customer_id: customer.id,
      merchant_id: merchant.id,
      created_at: "2012-03-27T14:54:05.000Z",
      updated_at: "2012-03-27T14:54:05.000Z"
    )
    item = Item.create!(name: "frog", description: "green", unit_price: 123, merchant_id: merchant.id)
    @ii1 = InvoiceItem.create!(quantity: 25,
                              unit_price: 223,
                              item_id: item.id,
                              invoice_id: invoice1.id,
                              created_at: "2012-03-27T14:54:05.000Z",
                              updated_at: "2012-03-27T14:54:05.000Z")
  end

  it "finds invoice item by id" do
    get "/api/v1/invoice_items/find?id=#{@ii1.id}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@ii1.id}")
    expect(results["data"]["attributes"]["quantity"]).to eq(@ii1.quantity)
    expect(results["data"]["attributes"]["unit_price"]).to eq("2.23")
    expect(results["data"]["attributes"]["item_id"]).to eq(@ii1.item_id)
    expect(results["data"]["attributes"]["invoice_id"]).to eq(@ii1.invoice_id)
  end

  it "finds invoice item by item_id" do
    get "/api/v1/invoice_items/find?item_id=#{@ii1.item_id}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@ii1.id}")
    expect(results["data"]["attributes"]["quantity"]).to eq(@ii1.quantity)
    expect(results["data"]["attributes"]["unit_price"]).to eq("2.23")
    expect(results["data"]["attributes"]["item_id"]).to eq(@ii1.item_id)
    expect(results["data"]["attributes"]["invoice_id"]).to eq(@ii1.invoice_id)
  end

  it "finds invoice item by invoice_id" do
    get "/api/v1/invoice_items/find?invoice_id=#{@ii1.invoice_id}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@ii1.id}")
    expect(results["data"]["attributes"]["quantity"]).to eq(@ii1.quantity)
    expect(results["data"]["attributes"]["unit_price"]).to eq("2.23")
    expect(results["data"]["attributes"]["item_id"]).to eq(@ii1.item_id)
    expect(results["data"]["attributes"]["invoice_id"]).to eq(@ii1.invoice_id)
  end
end
