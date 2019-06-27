class Merchant < ApplicationRecord

  has_many :invoices
  has_many :items

  def revenue
    # binding.pry
    InvoiceItem.joins(invoice: :transactions)
                .where(invoices: {merchant_id: self.id})
                .merge(Transaction.successful)
                .sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def favorite_customer(id)
    Customer.joins(invoices: :transactions)
            .where(invoices: {merchant_id: id})
            .merge(Transaction.successful)
            .select("customers.*, count(transactions.id) as total_count")
            .group(:id)
            .order("total_count desc")
            .limit(1)
  end

end
