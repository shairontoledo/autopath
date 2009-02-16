require 'pathname'
require 'recursive_path'
require 'load_package'
class AutoPath 

  def self.create(name,load_files=false)
    RecursivePath.create(name)
    LoadPackage.new(name,load_files)
  end
  
end

