class RevenueSerializer

  def initialize(id)
    @id = id
  end

  def get_data
    merchant = Merchant.find(@id)
    merchant.revenue
    data = {"data":
              {
                "id": "#{merchant.id}",
                "type": "revenue",
                "attributes": {
                                "revenue": '%.2f' % (merchant.revenue.to_i / 100.0)
                              }
              }
            }
    data
  end

end
