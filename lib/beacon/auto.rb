module Beacon
  class Auto
    class StdOutHandler
      def handle_beacon(beacon)
        puts "Beacon::StdOutHandler: received beacon #{beacon.inspect}"
      end
    end

    @@handler = StdOutHandler.new

    def self.handler=(handler)
     @@handler = handler
    end
     def self.current
       return @@handler
     end
    def self.handler
     @@handler
    end
  end
end
