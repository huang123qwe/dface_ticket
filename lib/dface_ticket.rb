require "dface_ticket/version"
require "dface_ticket/coupon"

module DfaceTicket
      def self.configure
          yield @config ||= Config.new
      end

      def self.config
          @config
      end
end