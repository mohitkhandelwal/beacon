require 'test_helper'
include Beacon

class BeaconControllerTest < ActiveSupport::TestCase
  setup do
    @controller = Beacon::BeaconController.new
  end
   def test_object_should_respond_to_handle_beacon
     assert_respond_to(Beacon::Auto.handler,"handle_beacon")
   end

  def test_handle_beacon_should_invoke_with_given_parameters

    @controller.params = {:t_done => 23, :t_page => 21, :t_resp => 34, :lat => 12, :bw_time => 21, :bw => 11234, :u => "localhost", :r => "localhost"}

    params = {:t_done => 23, :t_page => 21, :t_resp => 34, :lat => 12, :bw_time => 21, :bw => 11234, :u => "localhost", :r => "localhost"}
    obj = mock('object')
    Beacon::Auto.expects(:handler).times(1).returns(obj)

    obj.expects(:handle_beacon).with(:perceived_load_time => params[:t_done],
                                     :page_ready_time => params[:t_page],

                                     :request_to_first_byte_time => params[:t_resp],
                                     :latency => params[:lat],
                                     :bandwidth_measurement_timestamp => params[:bw_time],
                                     :bandwidth => params[:bw],
                                     :parent_url => params[:u],
                                     :url_set_start_beacon_time => params[:r]).times(1)


    @controller.beacon


  end
end
