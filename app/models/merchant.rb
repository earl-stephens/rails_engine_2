class Merchant < ApplicationRecord

  has_many :invoices
  has_many :items

  def revenue(date = nil)
    if date == nil
      get_revenue
    else
      get_revenue_by_date(date)
    end
  end

  def get_revenue_by_date(date)
    formatted_date = Merchant.format_the_date(date)
    InvoiceItem.joins(invoice: :transactions)
    .where(invoices: {merchant_id: self.id})
    .where(invoices: {created_at: formatted_date})
    .merge(Transaction.successful)
    .sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def get_revenue
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

  def self.sort_by_revenue(quantity)
    Merchant.joins(invoices: [:invoice_items, :transactions])
            .merge(Transaction.successful)
            .select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue")
            .group(:id)
            .order("total_revenue desc")
            .limit(quantity)
  end

  def self.sort_by_most_items(quantity)
    Merchant.joins(invoices: [:invoice_items, :transactions])
            .merge(Transaction.successful)
            .select("merchants.*, sum(invoice_items.quantity) as total_count")
            .group(:id)
            .order("total_count desc")
            .limit(quantity)
  end

  def self.get_total_revenue(date)
    formatted_date = format_the_date(date)
    InvoiceItem.joins(invoice: :transactions)
                .merge(Transaction.successful)
                .where(invoices: {created_at: formatted_date})
                .sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def self.format_the_date(date)
    DateTime.parse(date).all_day
  end

  def self.random
    Merchant.order('RANDOM()').first
  end

end
