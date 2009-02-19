require 'pathname'
require 'recursive_path'
require 'load_package'
class AutoPath 

  def self.create(name,load_files=false)
    RecursivePath.create(name.to_s)
    LoadPackage.new(name.to_s,load_files)
  end
  
end

