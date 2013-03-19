require 'test_helper'
require 'beacon'
require 'uri'

include Beacon
class AutoTest < ActiveSupport::TestCase


  def test_class_method_handler_mocking
    object =Beacon::Auto.new
    Beacon::Auto.expects(:handler).times(1).returns(object)

    assert_equal(Beacon::Auto.handler, object)

  end

  def test_class_method_current_mocking
    object =Beacon::Auto.new
    Beacon::Auto.expects(:current).times(1).returns(object)

    assert_equal(Beacon::Auto.current, object)
  end
  def test_class_method_handler_handler_mocking
    object =Beacon::Auto.new
    Beacon::Auto.expects(:handler).with("statsd").times(1).returns(object)

    assert_equal(Beacon::Auto.handler("statsd"), object)
  end
  def test_Stdouthandler_class_method_handle_beacon_mocking
    object =Beacon::Auto::StdOutHandler.new
    object.expects(:handle_beacon).with("params").returns(true)
    object.handle_beacon("params")
  end
end