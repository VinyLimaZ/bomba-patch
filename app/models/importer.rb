# frozen_string_literal: true

class Importer < ApplicationRecord
  enum step: { created: 0, importing: 1, finished: 2 }

  has_one_attached :csv

  def csv_path
    ActiveStorage::Blob.service.path_for(csv.key)
  end

  def enqueue_import
    ImporterCsvJob.perform_later(id)
  end

  def import!
    importing!
    Parsers::Csv::Parser.call(csv_path)
    finished!
  end
end
