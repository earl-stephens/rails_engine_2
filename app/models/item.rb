class Item < ApplicationRecord

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(quantity)
    # binding.pry
    Item.joins(invoice_items: [invoice: :transactions])
        .merge(Transaction.successful)
        .select("items.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue")
        .group(:id)
        .order("total_revenue desc")
        .limit(quantity)
  end

  def self.most_items(quantity)
    # binding.pry
    Item.joins(invoice_items: [invoice: :transactions])
        .merge(Transaction.successful)
        .select("items.*, sum(invoice_items.quantity) as total_count")
        .group(:id)
        .order("total_count desc")
        .limit(quantity)
  end

end
