module DfaceTicket
      class CouponNumber
            def initialize(options={})
                  options.symbolize_keys!.each do |key, value| 
                        class_eval{attr_accessor key}
                        send("#{key.to_s}=", value)
                  end
            end

             def self.create(coupon_number_attributes)
                    begin
                          coupon_number = JSON.parse(RestClient.post("#{DfaceTicket.config.host}/api/coupon_numbers", coupon_number_attributes))

                           if coupon_number["errcode"] == "0"
                                  DfaceTicket::CouponNumber.new(coupon_number["data"])
                           else
                                  nil
                           end
                    rescue Exception => e
                            nil
                    end
             end
      end
end