module Dockscan
module Module

class GenericModule
  def self.modules
    @modules ||= []
  end
  
  def self.inherited(klass)
    @modules ||= []
    
    @modules << klass
  end
end # Class

end # Module
end # Dockscan
