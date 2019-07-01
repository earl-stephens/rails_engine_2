require "rails_helper"

RSpec.describe 'transaction single finders', type: :request do
  before :each do
    merchant = Merchant.create!(name: "Kermit")
    item1 = Item.create!(name: "frog", description: "green", unit_price: 2345, merchant_id: merchant.id)
    customer = Customer.create!(first_name: "Jim", last_name: "Henson")
    invoice1 = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant.id)
    ii1 = InvoiceItem.create!(quantity: 45, unit_price: 100, item_id: item1.id, invoice_id: invoice1.id)
    @transaction1 = Transaction.create!(credit_card_number: 1234,
                                        result: "success",
                                        invoice_id: invoice1.id,
                                        created_at: "2012-03-27T14:54:05.000Z",
                                        updated_at: "2012-03-27T14:54:05.000Z")
  end

  it "finds transaction by id" do
    get "/api/v1/transactions/find?id=#{@transaction1.id}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@transaction1.id}")
    expect(results["data"]["attributes"]["invoice_id"]).to eq(@transaction1.invoice_id)
    expect(results["data"]["attributes"]["credit_card_number"]).to eq(@transaction1.credit_card_number)
    expect(results["data"]["attributes"]["result"]).to eq(@transaction1.result)
  end

  it "finds transaction by invoice_id" do
    get "/api/v1/transactions/find?invoice_id=#{@transaction1.invoice_id}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@transaction1.id}")
    expect(results["data"]["attributes"]["invoice_id"]).to eq(@transaction1.invoice_id)
    expect(results["data"]["attributes"]["credit_card_number"]).to eq(@transaction1.credit_card_number)
    expect(results["data"]["attributes"]["result"]).to eq(@transaction1.result)
  end

  it "finds transaction by credit_card_number" do
    get "/api/v1/transactions/find?credit_card_number=#{@transaction1.credit_card_number}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@transaction1.id}")
    expect(results["data"]["attributes"]["invoice_id"]).to eq(@transaction1.invoice_id)
    expect(results["data"]["attributes"]["credit_card_number"]).to eq(@transaction1.credit_card_number)
    expect(results["data"]["attributes"]["result"]).to eq(@transaction1.result)
  end

  it "finds transaction by result" do
    get "/api/v1/transactions/find?result=#{@transaction1.result}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@transaction1.id}")
    expect(results["data"]["attributes"]["invoice_id"]).to eq(@transaction1.invoice_id)
    expect(results["data"]["attributes"]["credit_card_number"]).to eq(@transaction1.credit_card_number)
    expect(results["data"]["attributes"]["result"]).to eq(@transaction1.result)
  end

  it "finds transaction by created_at" do
    get "/api/v1/transactions/find?created_at=#{@transaction1.created_at}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@transaction1.id}")
    expect(results["data"]["attributes"]["invoice_id"]).to eq(@transaction1.invoice_id)
    expect(results["data"]["attributes"]["credit_card_number"]).to eq(@transaction1.credit_card_number)
    expect(results["data"]["attributes"]["result"]).to eq(@transaction1.result)
  end

  it "finds transaction by updated_at" do
    get "/api/v1/transactions/find?updated_at=#{@transaction1.updated_at}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"]["id"]).to eq("#{@transaction1.id}")
    expect(results["data"]["attributes"]["invoice_id"]).to eq(@transaction1.invoice_id)
    expect(results["data"]["attributes"]["credit_card_number"]).to eq(@transaction1.credit_card_number)
    expect(results["data"]["attributes"]["result"]).to eq(@transaction1.result)
  end
end
