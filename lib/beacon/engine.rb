  module Beacon
  class Engine < ::Rails::Engine
    isolate_namespace Beacon
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
  end
end
