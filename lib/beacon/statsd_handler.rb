require 'sc_metrics'
require 'uri'
#require 'string'
module Beacon
  class StatsdHandler
    def initialize(host_name, port)
      @host_name = host_name
      @port = port
     # @routes = routes
    end

    def handle_beacon(beacon)
      begin
        myuri=URI.parse(beacon[:parent_url])
        myhost= myuri.host
        mypath= myuri.path

        mypath.slice!(0)

        myhost = myhost.gsub(/[^a-z_A-z0-9-]/, "_")

        a = Rails.application.routes.recognize_path(mypath)

        return unless a[:controller] && a[:action]
        # return unless @routes.include?({:controller => a[:controller], :action => a[:action]})

        controller_name = "#{a[:controller]}_controller".classify
        mypath = "#{controller_name}.#{a[:action]}"
        statsd = Statsd.new(@host_name, @port)
        statsd.timing("#{myhost}.#{mypath}.beacon.perceived_load_time", beacon[:perceived_load_time])
        statsd.timing("#{myhost}.#{mypath}.beacon.page_ready_time", beacon[:page_ready_time])
        statsd.timing("#{myhost}.#{mypath}.beacon.time_to_first_byte", beacon[:request_to_first_byte_time])
        statsd.timing("#{myhost}.#{mypath}.beacon.latency", beacon[:latency])
        statsd.gauge("#{myhost}.#{mypath}.beacon.bandwidth", beacon[:bandwidth])
      rescue =>e
        Rails.logger.error "in handle_beacon #{e.class} #{e.message}"
      end
    end
  end
end



