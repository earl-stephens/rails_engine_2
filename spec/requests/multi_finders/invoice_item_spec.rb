require "rails_helper"

RSpec.describe 'invoice item multi finders', type: :request do
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
                              created_at: "2011-03-27T14:54:05.000Z",
                              updated_at: "2011-03-27T14:54:05.000Z")
    @ii2 = InvoiceItem.create!(quantity: 43,
                              unit_price: 211,
                              item_id: item.id,
                              invoice_id: invoice1.id,
                              created_at: "2012-03-27T14:54:05.000Z",
                              updated_at: "2012-03-27T14:54:05.000Z")
    @ii3 = InvoiceItem.create!(quantity: 86,
                              unit_price: 58,
                              item_id: item.id,
                              invoice_id: invoice1.id,
                              created_at: "2012-03-27T14:54:05.000Z",
                              updated_at: "2012-03-27T14:54:05.000Z")
  end

  it "finds invoice items by id" do
    get "/api/v1/invoice_items/find_all?id=#{@ii2.id}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(["data"].count).to eq(1)
    expect(results["data"][0]["id"]).to eq("#{@ii2.id}")
    expect(results["data"][0]["attributes"]["quantity"]).to eq(@ii2.quantity)
    expect(results["data"][0]["attributes"]["unit_price"]).to eq("2.11")
    expect(results["data"][0]["attributes"]["item_id"]).to eq(@ii2.item_id)
    expect(results["data"][0]["attributes"]["invoice_id"]).to eq(@ii2.invoice_id)
  end

  it "finds invoice items by item_id" do
    get "/api/v1/invoice_items/find_all?item_id=#{@ii1.item_id}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"].count).to eq(3)
    expect(results["data"][0]["id"]).to eq("#{@ii1.id}")
    expect(results["data"][1]["attributes"]["quantity"]).to eq(@ii2.quantity)
    expect(results["data"][1]["attributes"]["unit_price"]).to eq("2.11")
    expect(results["data"][2]["attributes"]["item_id"]).to eq(@ii3.item_id)
    expect(results["data"][2]["attributes"]["invoice_id"]).to eq(@ii3.invoice_id)
  end

  it "finds invoice items by invoice_id" do
    get "/api/v1/invoice_items/find_all?invoice_id=#{@ii1.invoice_id}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"].count).to eq(3)
    expect(results["data"][0]["id"]).to eq("#{@ii1.id}")
    expect(results["data"][1]["attributes"]["quantity"]).to eq(@ii2.quantity)
    expect(results["data"][1]["attributes"]["unit_price"]).to eq("2.11")
    expect(results["data"][2]["attributes"]["item_id"]).to eq(@ii3.item_id)
    expect(results["data"][2]["attributes"]["invoice_id"]).to eq(@ii3.invoice_id)
  end
end
