require "rails_helper"

RSpec.describe 'customer', type: :request do
  it "shows customer to transaction relationship" do
    merchant1 = Merchant.create!(name: "Kermit")
    item1 = Item.create!(name: "frog", description: "green", unit_price: 2345, merchant_id: merchant1.id)
    item2 = Item.create!(name: "bear", description: "brown", unit_price: 3344, merchant_id: merchant1.id)
    item3 = Item.create!(name: "pig", description: "pink", unit_price: 3344, merchant_id: merchant1.id)
    customer1 = Customer.create!(first_name: "Jim", last_name: "Henson")
    customer2 = Customer.create!(first_name: "Frank", last_name: "Oz")
    invoice1 = Invoice.create!(status: "shipped", customer_id: customer1.id, merchant_id: merchant1.id)
    invoice2 = Invoice.create!(status: "shipped", customer_id: customer1.id, merchant_id: merchant1.id)
    invoice3 = Invoice.create!(status: "shipped", customer_id: customer2.id, merchant_id: merchant1.id)
    invoice4 = Invoice.create!(status: "shipped", customer_id: customer1.id, merchant_id: merchant1.id)
    invoice5 = Invoice.create!(status: "shipped", customer_id: customer1.id, merchant_id: merchant1.id)
    invoice6 = Invoice.create!(status: "shipped", customer_id: customer2.id, merchant_id: merchant1.id)
    transaction1 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice1.id)
    transaction2 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice2.id)
    transaction3 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice3.id)
    transaction4 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice4.id)
    transaction5 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice5.id)
    transaction6 = Transaction.create!(credit_card_number: "9876", result: "success", invoice_id: invoice6.id)

    get "/api/v1/customers/#{customer1.id}/transactions"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"].count).to eq(4)
    expect(results["data"][0]["attributes"]["result"]).to eq("success")
    expect(results["data"][1]["attributes"]["invoice_id"]).to eq(invoice2.id)
    expect(results["data"][1]["attributes"]["credit_card_number"]).to eq("9876")
  end
end
