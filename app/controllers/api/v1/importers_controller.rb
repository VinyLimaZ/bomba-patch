# frozen_string_literal: true

module Api
  module V1
    class ImportersController < ApplicationController
      def create
        @importer = Importer.create(importer_params)
        @importer.enqueue_import
      end

      private

      def importer_params
        params.require(:importer).permit(:csv)
      end
    end
  end
end
