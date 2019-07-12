
module EJP
  module Schema    
    class EUPID
        attr_accessor :id  
        attr_accessor :eupid
        
        def initialize(params = {})
          SioHelper::General.setNamespaces()
          
          @name = params.fetch(:name, 'Some Person')
          
        end
    end
  end
end

 