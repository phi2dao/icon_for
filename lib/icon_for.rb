require "icon_for/engine"
require "icon_for/icon_set"
require "icon_for/path"
require "icon_for/version"

module IconFor
  File.open IconFor::PATH + "/fa.json" do |file|
    IconFor.register :FA, file, default: Kernel.const_defined?(:FontAwesome)
  end
end
