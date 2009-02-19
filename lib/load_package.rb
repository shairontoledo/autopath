
class LoadPackage
  def initialize(_name,load_files=false)
    $LOAD_PATH << _name

    @load_files=load_files
    name=camelize(File.basename(_name))
    root=if Object.constants.include? name
      Object.const_get name
    else
      Object.const_set name, Module.new
    end

    perform(root,Pathname.new(_name))
  end

  def camelize(str)
    str.split(/_/).map{|v| v.capitalize}.join
  end
  
  def add_module(parent,child_name)
    #puts "parent: #{parent},#{child_name}"
    mod=Module.new
    mod=parent.const_get(child_name) if parent.constants.include?(child_name)
    parent.const_set(child_name, mod)
  end

  def perform(parent,node)
    # puts "PERFORM: #{parent},#{node}"
    node.children.each do |d|
      next if d.basename.to_s =~ /^\./
      if d.directory?
        new_parent=add_module(parent,camelize(d.basename.to_s) )
        perform(new_parent,d)
      elsif d.basename.to_s =~ /\.rb$/
        #puts "require '#{d.to_s}'"
        require d.to_s if @load_files
      end
    end
  end
end