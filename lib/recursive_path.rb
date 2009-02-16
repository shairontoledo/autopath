class RecursivePath < String

  def method_missing(meth)
     RecursivePath.new(File.join(self,meth.to_s))
  end

  def self.create(name)
    Kernel.module_eval do
      define_method(File.basename(name.to_s)) {  RecursivePath.new(name.to_s.dup)  }
    end
  end

end

