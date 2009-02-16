
class LoadPackage
  def initialize(_name,load_files=false)
    $LOAD_PATH << _name
    name=camelize(File.basename(_name))
    root=Object.const_set name, Module.new
    perform(root,Pathname.new(_name))
    @load_files=load_files
  end

  def camelize(str)
    str.split(/_/).map{|v| v.capitalize}.join
  end
  
  def add_module(parent,child_name)
    parent.const_set(child_name, Module.new)
  end

  def perform(parent,node)
    #puts "PERFORM: #{parent},#{node}"
    node.children.each do |d|
      next if d.basename.to_s =~ /^\./
      if d.directory?
        new_parent=add_module(parent,camelize(d.basename.to_s) )
        perform(new_parent,d)
      elsif d.basename.to_s =~ /\.rb$/
        require d.to_s if @load_files
        #puts "FILE: #{d.basename} -> #{d.to_s}"
      end
    end
  end
end