class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :item_id, :invoice_id, :quantity

  attribute :unit_price do |object|
    # binding.pry
    '%.2f' % (object.unit_price.to_i / 100.0)
  end
end
