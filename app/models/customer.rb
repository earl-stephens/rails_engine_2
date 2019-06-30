class Customer < ApplicationRecord

  has_many :invoices

  def favorite_merchant
    Merchant.joins(invoices: :transactions)
            .where(invoices: {customer_id: self.id})
            .merge(Transaction.successful)
            .select("merchants.*, count(transactions.id) as total_count")
            .group(:id)
            .order("total_count desc")
            .first
  end

  def get_transactions
    Transaction.joins(invoice: :customer)
                .where(customers: {id: self.id})
  end

end
