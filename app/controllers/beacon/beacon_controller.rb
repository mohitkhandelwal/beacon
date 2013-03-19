require 'sc_metrics'

module Beacon
  class BeaconController < ApplicationController
    def beacon


      Auto.handler.handle_beacon(:perceived_load_time => params[:t_done],
                                   :page_ready_time => params[:t_page],

          :request_to_first_byte_time => params[:t_resp],
                                   :latency => params[:lat],
                                   :bandwidth_measurement_timestamp => params[:bw_time],
                                   :bandwidth => params[:bw],
                                   :parent_url => params[:u],
                                   :url_set_start_beacon_time => params[:r])


      end
    end
  end



