require "rails_helper"

RSpec.describe 'items biz intel' do
  it "returns top items by total revenue" do
    merchant1 = Merchant.create!(name: "Kermit")
    item1 = Item.create!(name: "frog", description: "green", unit_price: 2345, merchant_id: merchant1.id)
    item2 = Item.create!(name: "pig", description: "pink", unit_price: 3344, merchant_id: merchant1.id)
    item3 = Item.create!(name: "bear", description: "brown", unit_price: 1231, merchant_id: merchant1.id)
    customer = Customer.create!(first_name: "Jim", last_name: "Henson")
    invoice1 = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant1.id)
    invoice2 = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant1.id)
    invoice3 = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant1.id)
    invoice4 = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant1.id)
    ii1 = InvoiceItem.create!(quantity: 45, unit_price: 100, item_id: item1.id, invoice_id: invoice1.id)
    ii2 = InvoiceItem.create!(quantity: 12, unit_price: 24, item_id: item2.id, invoice_id: invoice2.id)
    ii3 = InvoiceItem.create!(quantity: 30, unit_price: 50, item_id: item1.id, invoice_id: invoice3.id)
    ii4 = InvoiceItem.create!(quantity: 35, unit_price: 10, item_id: item3.id, invoice_id: invoice4.id)
    transaction1 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice1.id)
    transaction2 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice2.id)
    transaction3 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice3.id)
    transaction4 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice4.id)

    get "/api/v1/items/most_revenue?quantity=2"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"][0]["attributes"]["name"]).to eq("frog")
    expect(results["data"][0]["attributes"]["id"]).to eq(item1.id)
    expect(results["data"][1]["attributes"]["name"]).to eq("bear")
    expect(results["data"][1]["attributes"]["id"]).to eq(item3.id)
  end

  it "returns top items by total number sold" do
    merchant1 = Merchant.create!(name: "Kermit")
    item1 = Item.create!(name: "frog", description: "green", unit_price: 2345, merchant_id: merchant1.id)
    item2 = Item.create!(name: "pig", description: "pink", unit_price: 3344, merchant_id: merchant1.id)
    item3 = Item.create!(name: "bear", description: "brown", unit_price: 1231, merchant_id: merchant1.id)
    customer = Customer.create!(first_name: "Jim", last_name: "Henson")
    invoice1 = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant1.id)
    invoice2 = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant1.id)
    invoice3 = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant1.id)
    invoice4 = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant1.id)
    ii1 = InvoiceItem.create!(quantity: 45, unit_price: 100, item_id: item1.id, invoice_id: invoice1.id)
    ii2 = InvoiceItem.create!(quantity: 1250, unit_price: 24, item_id: item2.id, invoice_id: invoice2.id)
    ii3 = InvoiceItem.create!(quantity: 30, unit_price: 50, item_id: item1.id, invoice_id: invoice3.id)
    ii4 = InvoiceItem.create!(quantity: 35, unit_price: 10, item_id: item3.id, invoice_id: invoice4.id)
    transaction1 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice1.id)
    transaction2 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice2.id)
    transaction3 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice3.id)
    transaction4 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice4.id)

    get "/api/v1/items/most_items?quantity=2"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"][0]["attributes"]["id"]).to eq(item2.id)
    expect(results["data"][0]["attributes"]["name"]).to eq(item2.name)
    expect(results["data"][1]["attributes"]["id"]).to eq(item1.id)
    expect(results["data"][0]["attributes"]["name"]).to eq(item2.name)
  end

  it "returns the best day" do
    merchant1 = Merchant.create!(name: "Kermit")
    item1 = Item.create!(name: "frog", description: "green", unit_price: 2345, merchant_id: merchant1.id)
    item2 = Item.create!(name: "pig", description: "pink", unit_price: 3344, merchant_id: merchant1.id)
    item3 = Item.create!(name: "bear", description: "brown", unit_price: 1231, merchant_id: merchant1.id)
    customer = Customer.create!(first_name: "Jim", last_name: "Henson")
    invoice1 = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant1.id, created_at: "2019-06-25 09:54:09 UTC")
    invoice2 = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant1.id, created_at: "2019-06-26 09:54:09 UTC")
    invoice3 = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant1.id, created_at: "2019-06-24 09:54:09 UTC")
    invoice4 = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant1.id, created_at: "2019-06-26 09:54:09 UTC")
    ii1 = InvoiceItem.create!(quantity: 45, unit_price: 100, item_id: item1.id, invoice_id: invoice1.id, created_at: "2019-06-25 09:54:09 UTC")
    ii2 = InvoiceItem.create!(quantity: 1250, unit_price: 24, item_id: item2.id, invoice_id: invoice2.id, created_at: "2019-06-26 09:54:09 UTC")
    ii3 = InvoiceItem.create!(quantity: 45, unit_price: 100, item_id: item1.id, invoice_id: invoice3.id, created_at: "2019-06-24 09:54:09 UTC")
    ii4 = InvoiceItem.create!(quantity: 35, unit_price: 10, item_id: item2.id, invoice_id: invoice4.id, created_at: "2019-06-26 09:54:09 UTC")
    transaction1 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice1.id)
    transaction2 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice2.id)
    transaction3 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice3.id)
    transaction4 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice4.id)

    get "/api/v1/items/#{item1.id}/best_day"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["attributes"]["best_day"]).to eq("2019-06-25")
  end
end
