module DfaceTicket
      class CouponDown
            def initialize(options={})
                  options.symbolize_keys!.each do |key, value| 
                        class_eval{attr_accessor key}
                        send("#{key.to_s}=", value)
                  end
            end

             def send_xmpp

             end
      end
end