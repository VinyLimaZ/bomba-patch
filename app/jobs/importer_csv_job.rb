# frozen_string_literal: true

class ImporterCsvJob < ApplicationJob
  def perform(import_id)
    importer = Importer.find(import_id)
    importer.import!
  end
end
