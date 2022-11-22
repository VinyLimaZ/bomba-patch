class ProcessCsvService < ApplicationService
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def call
    ActiveStorage::Blob.create_and_upload!(io: @file, filename: @file.original_filename)
  end
end
