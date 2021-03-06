require "rails_helper"

RSpec.describe 'transaction multi finder', type: :request do
  before :each do
    merchant = Merchant.create!(name: "Kermit")
    item1 = Item.create!(name: "frog", description: "green", unit_price: 2345, merchant_id: merchant.id)
    customer = Customer.create!(first_name: "Jim", last_name: "Henson")
    invoice1 = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant.id)
    invoice2 = Invoice.create!(status: "shipped", customer_id: customer.id, merchant_id: merchant.id)
    ii1 = InvoiceItem.create!(quantity: 45, unit_price: 100, item_id: item1.id, invoice_id: invoice1.id)
    @transaction1 = Transaction.create!(credit_card_number: 1234,
                                        result: "failed",
                                        invoice_id: invoice1.id,
                                        created_at: "2012-03-27T14:54:05.000Z",
                                        updated_at: "2012-03-27T14:54:05.000Z")
    @transaction2 = Transaction.create!(credit_card_number: 1234,
                                        result: "success",
                                        invoice_id: invoice1.id,
                                        created_at: "2011-03-27T14:54:05.000Z",
                                        updated_at: "2011-03-27T14:54:05.000Z")
    @transaction3 = Transaction.create!(credit_card_number: 2345,
                                        result: "success",
                                        invoice_id: invoice2.id,
                                        created_at: "2012-03-27T14:54:05.000Z",
                                        updated_at: "2012-03-27T14:54:05.000Z")
  end

  it "finds transactions by id" do
    get "/api/v1/transactions/find_all?id=#{@transaction1.id}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"].count).to eq(1)
    expect(results["data"][0]["id"]).to eq("#{@transaction1.id}")
    expect(results["data"][0]["attributes"]["invoice_id"]).to eq(@transaction1.invoice_id)
    expect(results["data"][0]["attributes"]["credit_card_number"]).to eq(@transaction1.credit_card_number)
    expect(results["data"][0]["attributes"]["result"]).to eq(@transaction1.result)
  end

  it "finds transactions by invoice_id" do
    get "/api/v1/transactions/find_all?invoice_id=#{@transaction1.invoice_id}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"].count).to eq(2)
    expect(results["data"][0]["id"]).to eq("#{@transaction1.id}")
    expect(results["data"][0]["attributes"]["invoice_id"]).to eq(@transaction1.invoice_id)
    expect(results["data"][1]["attributes"]["credit_card_number"]).to eq(@transaction2.credit_card_number)
    expect(results["data"][1]["attributes"]["result"]).to eq(@transaction2.result)
  end

  it "finds transactions by credit_card_number" do
    get "/api/v1/transactions/find_all?credit_card_number=#{@transaction1.credit_card_number}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"].count).to eq(2)
    expect(results["data"][0]["id"]).to eq("#{@transaction1.id}")
    expect(results["data"][0]["attributes"]["invoice_id"]).to eq(@transaction1.invoice_id)
    expect(results["data"][1]["attributes"]["credit_card_number"]).to eq(@transaction2.credit_card_number)
    expect(results["data"][1]["attributes"]["result"]).to eq(@transaction2.result)
  end

  it "finds transactions by result" do
    get "/api/v1/transactions/find_all?result=#{@transaction2.result}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"].count).to eq(2)
    expect(results["data"][0]["id"]).to eq("#{@transaction2.id}")
    expect(results["data"][0]["attributes"]["invoice_id"]).to eq(@transaction2.invoice_id)
    expect(results["data"][1]["attributes"]["credit_card_number"]).to eq(@transaction3.credit_card_number)
    expect(results["data"][1]["attributes"]["result"]).to eq(@transaction3.result)
  end

  it "finds transactions by created_at" do
    get "/api/v1/transactions/find_all?created_at=#{@transaction1.created_at}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"].count).to eq(2)
    expect(results["data"][0]["id"]).to eq("#{@transaction1.id}")
    expect(results["data"][0]["attributes"]["invoice_id"]).to eq(@transaction1.invoice_id)
    expect(results["data"][1]["attributes"]["credit_card_number"]).to eq(@transaction3.credit_card_number)
    expect(results["data"][1]["attributes"]["result"]).to eq(@transaction3.result)
  end

  it "finds transactions by updated_at" do
    get "/api/v1/transactions/find_all?updated_at=#{@transaction1.updated_at}"

    results = JSON.parse(response.body)

    expect(response).to be_successful
    expect(results["data"].count).to eq(2)
    expect(results["data"][0]["id"]).to eq("#{@transaction1.id}")
    expect(results["data"][0]["attributes"]["invoice_id"]).to eq(@transaction1.invoice_id)
    expect(results["data"][1]["attributes"]["credit_card_number"]).to eq(@transaction3.credit_card_number)
    expect(results["data"][1]["attributes"]["result"]).to eq(@transaction3.result)
  end
end
