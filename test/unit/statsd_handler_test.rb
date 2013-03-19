require 'test_helper'
require 'uri'
include URI
include Beacon
class StatsdHandlerTest < ActiveSupport::TestCase

  setup do
    @newobject=Beacon::StatsdHandler.new("localhost", 8125)
    @params={:t_done => 23, :t_page => 21, :t_resp => 34, :lat => 12, :bw_time => 21, :bw => 11234, :u => "http://localhost/home/index", :r => "http://localhost/home/index"}


  end

  def test_raise_exception


    URI.expects(:parse)

    Rails.logger.expects(:error)

    @newobject.handle_beacon(:perceived_load_time => @params[:t_done],
                             :page_ready_time => @params[:t_page],
                             :request_to_first_byte_time => @params[:t_resp],
                             :latency => @params[:lat],
                             :bandwidth_measurement_timestamp => @params[:bw_time],
                             :bandwidth => @params[:bw],
                             :parent_url =>"localhost/home/index" ,
                             :url_set_start_beacon_time => @params[:r])



  end


  def test_class_method_handle_beacon_should_send_params_to_Statsd
    path={:controller => "home", :action => "index"}
    statsdobj = mock()

    Rails.application.routes.expects(:recognize_path).returns(path)


    Statsd.expects(:new).times(1).returns(statsdobj)
    statsdobj.expects(:timing).with('localhost.HomeController.index.beacon.perceived_load_time', @params[:t_done]).times(1)
    statsdobj.expects(:timing).with('localhost.HomeController.index.beacon.page_ready_time', @params[:t_page]).times(1)
    statsdobj.expects(:timing).with('localhost.HomeController.index.beacon.time_to_first_byte', @params[:t_resp]).times(1)
    statsdobj.expects(:timing).with('localhost.HomeController.index.beacon.latency', @params[:lat]).times(1)

    statsdobj.expects(:gauge).once
    @newobject.handle_beacon(:perceived_load_time => @params[:t_done],
                             :page_ready_time => @params[:t_page],
                             :request_to_first_byte_time => @params[:t_resp],
                             :latency => @params[:lat],
                             :bandwidth_measurement_timestamp => @params[:bw_time],
                             :bandwidth => @params[:bw],
                             :parent_url => @params[:u],
                             :url_set_start_beacon_time => @params[:r])


  end

end