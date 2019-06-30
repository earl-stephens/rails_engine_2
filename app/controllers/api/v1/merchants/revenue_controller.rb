module Api
  module V1
    module Merchants
      class RevenueController < ApplicationController

        def index
          date = params[:date]
          render json: TotalRevenueSerializer.new.get_data(date)
        end

      end
    end
  end
end
