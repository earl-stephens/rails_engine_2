class RevenueSerializer

  def initialize(id, date)
    @id = id
    @date = date
  end

  def get_data
    merchant = Merchant.find(@id)
    merchant.revenue(@date)
    data = {"data":
              {
                "id": "#{merchant.id}",
                "type": "revenue",
                "attributes": {
                                "revenue": '%.2f' % (merchant.revenue(@date).to_i / 100.0)
                              }
              }
            }
            # binding.pry
    data
  end

end
