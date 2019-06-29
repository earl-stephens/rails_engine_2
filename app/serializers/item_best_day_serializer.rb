class ItemBestDaySerializer

  def get_data(item_to_lookup)
    best_date = formatted_date(item_to_lookup)
    data = {
      "data": {
        "id": item_to_lookup.id,
        "type": "best_day",
        "attributes": {
          "best_day": best_date
        }
      }
    }
  end

  def formatted_date(item_to_lookup)
    item_object = item_to_lookup.find_best_day
    item_date = item_object.created_at
    item_date.strftime("%Y-%m-%d")
  end

end
