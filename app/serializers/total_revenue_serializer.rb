class TotalRevenueSerializer

  def get_data(date)
    total_revenue = Merchant.get_total_revenue(date)
    data = {
      "data": {
        "attributes": {
          "total_revenue": '%.2f' % (total_revenue.to_i / 100.0)
        }
      }
    }
    data
  end

end
