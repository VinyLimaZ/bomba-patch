module Api
  module V1
    class CsvController < ApplicationController
      def create
        if Services::Csv::Validator.call(csv_params)
          Services::Csv::Parser.call(csv_params)

          head :ok
        else
          render json: errors
        end
      end

      private

      def errors
        { errors: Services::CSV::Error.call(csv_params).full_messages }
      end

      def csv_params
        params.require(:csv).permit(:data)
      end
    end
  end
end
