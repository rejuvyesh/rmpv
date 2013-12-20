# local libs
Dir["#{File.join(File.dirname(__FILE__), "backup-urls")}/*.rb"].each do |lib|
  require lib
end

module Rmpv

end
