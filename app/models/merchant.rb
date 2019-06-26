class Merchant < ApplicationRecord

  has_many :invoices
  has_many :items

  def revenue
    # binding.pry
    InvoiceItem.joins(invoice: :transactions)
                .where(invoices: {merchant_id: self.id})
                .where(transactions: {result: "success"})
                .sum("invoice_items.quantity * invoice_items.unit_price")
  end

end
