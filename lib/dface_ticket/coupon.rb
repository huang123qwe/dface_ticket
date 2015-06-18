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
                        coupons = JSON.parse(RestClient.get("#{config.host}/coupons?#{hash.to_param}"))
                        if coupons["errcode"] == "0"
                              coupons.map{|coupon| new(coupon)}
                        else
                              coupons
                        end
                  rescue 
                       nil
                  end
            end

           def download(user_id, options={})
                  begin
                        out_indent = "#{Time.now.to_i.to_s(36)}#{coupon['id']}#{4.times.map{|m| rand(36).to_s(36)}.join}"
                        coupon_down = JSON.parse(RestClient.post("#{config.host}/coupon_downs", options.merge(out_indent: out_indent, user_id: user_id))
                        if coupon_down["errcode"] == "0"
                            CouponDown.new(coupon_down)
                        else
                            coupon_down
                        end
                  rescue
                        nil
                  end
            end

      end
end