require "dface_ticket/version"
require "dface_ticket/coupon"
require "dface_ticket/coupon_down"
require "dface_ticket/configure"


module DfaceTicket
      def self.configure
          yield @config ||= DfaceTicket::Configure.new
      end

      def self.config
          @config ||= DfaceTicket::Configure.new
      end
end