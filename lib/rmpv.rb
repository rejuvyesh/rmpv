require "rmpv/version"
require "traktr"
require "myanimelist"

# local libs
Dir["#{File.join(File.dirname(__FILE__), "rmpv")}/*.rb"].each do |lib|
  require lib
end
