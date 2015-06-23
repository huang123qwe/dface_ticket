module DfaceTicket
      class Configure
          attr_accessor :host
          def initialize(options={})
                options.symbolize_keys!
                @host = options[:host]||"http://ticket.dface.cn"
                yield self if block_given?
          end
      end
end