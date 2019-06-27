class FavoriteCustomerSerializer
  attr_reader :id

  def initialize(id)
    @id = id
  end

  def get_data
    merchant = Merchant.find(@id)
    customer_id = merchant.favorite_customer(@id)
    data = {
      "data": {
        "id": "#{merchant.id}",
        "type": "revenue",
        "attributes": {
          "id": customer_id[0].id
        }
      }
    }
    data
  end

end
