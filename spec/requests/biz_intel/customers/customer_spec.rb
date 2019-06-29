require "rails_helper"

RSpec.describe 'customer business intelligence', type: :request do
  it "finds a customers favorite customer" do
    merchant1 = Merchant.create!(name: "Kermit")
    merchant2 = Merchant.create!(name: "Fozzy Bear")
    merchant3 = Merchant.create!(name: "Gonzo")
    item1 = Item.create!(name: "frog", description: "green", unit_price: 2345, merchant_id: merchant1.id)
    item2 = Item.create!(name: "pig", description: "pink", unit_price: 3344, merchant_id: merchant2.id)
    item3 = Item.create!(name: "bear", description: "brown", unit_price: 1231, merchant_id: merchant3.id)
    customer = Customer.create!(first_name: "Jim", last_name: "Henson")
    invoice1 = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant1.id)
    invoice2 = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant2.id)
    invoice3 = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant1.id)
    invoice4 = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant3.id)
    ii1 = InvoiceItem.create!(quantity: 45, unit_price: 100, item_id: item1.id, invoice_id: invoice1.id)
    ii2 = InvoiceItem.create!(quantity: 35, unit_price: 10, item_id: item2.id, invoice_id: invoice2.id)
    ii3 = InvoiceItem.create!(quantity: 30, unit_price: 50, item_id: item1.id, invoice_id: invoice3.id)
    ii4 = InvoiceItem.create!(quantity: 12, unit_price: 24, item_id: item3.id, invoice_id: invoice4.id)
    transaction1 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice1.id)
    transaction2 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice2.id)
    transaction3 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice3.id)
    transaction4 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice4.id)

    get "/api/v1/customers/#{customer.id}/favorite_merchant"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["attributes"]["name"]).to eq(merchant1.name)
    expect(results["data"]["attributes"]["id"]).to eq(merchant1.id)
  end
end
