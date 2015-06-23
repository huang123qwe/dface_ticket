module DfaceTicket
      class Coupon
            def initialize(options={})
                  options.symbolize_keys!.each do |key, value| 
                        class_eval{attr_accessor key}
                        send("#{key.to_s}=", value)
                  end
            end

            def self.fetch(token, appid, shop_id, real_shop_id=nil)
                  begin
                        hash = {token: token, appid: appid, shop_id: shop_id, real_shop_id: real_shop_id}
                        coupons = JSON.parse(RestClient.get("#{DfaceTicket.config.host}/coupons?#{hash.to_param}"))
                        if coupons["errcode"] == "0"
                              coupons["data"].map{|coupon| new(coupon)}
                        else
                              coupons
                        end
                  rescue 
                       []
                  end
            end
#shop_id  发布的商家
           def download(token, appid, user_id, shop_id=real_shop_id)
                  begin
                        out_indent = "#{Time.now.to_i.to_s(36)}#{self.id}#{4.times.map{|m| rand(36).to_s(36)}.join}"
                        hash = {out_indent: out_indent, token: token, user_id: user_id, shop_id: shop_id, id: self.id, appid: appid}
                        coupon_down = JSON.parse(RestClient.post("#{DfaceTicket.config.host}/coupon_downs", hash))
                        if coupon_down["errcode"] == "0"
                            DfaceTicket::CouponDown.new(coupon_down["data"])
                        else
                            coupon_down
                        end
                  rescue
                        nil
                  end
            end

      end
end