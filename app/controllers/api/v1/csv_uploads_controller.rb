# frozen_string_literal: true

module Api
  module V1
    class CsvUploadsController < ApplicationController
      def create
        ProcessCsvService.call(csv_uploads_params)
      end

      private

      def csv_uploads_params
        params.require(:csv_upload).permit(:file)
      end
    end
  end
end
