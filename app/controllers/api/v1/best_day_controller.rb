module Api
  module V1
    class BestDayController < ApplicationController

      def show
        item_to_lookup = Item.find(params[:item_id])
        render json: ItemBestDaySerializer.new.get_data(item_to_lookup)
      end

    end
  end
end
