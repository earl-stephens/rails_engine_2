module Api
  module V1
    class InvoicesController < ApplicationController

      def index
        render json: InvoiceSerializer.new(Invoice.all)
      end

      def show
        render json: InvoiceSerializer.new(Invoice.find(params[:id]))
      end

    end
  end
end
