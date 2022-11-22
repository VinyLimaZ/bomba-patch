require 'csv'
module Services
  module CSV
    class Validator < Base
      class << self
        private

        def validator(csv)
          return true if ::CSV.parse_line(csv).count == 8

          false
        end
      end
    end
  end
end
