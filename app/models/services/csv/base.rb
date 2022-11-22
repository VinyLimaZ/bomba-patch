module Services
  module CSV
    class Base
      def self.call(csv)
        send(:"#{self.class.to_s.downcase}", csv)
      end
    end
  end
end
