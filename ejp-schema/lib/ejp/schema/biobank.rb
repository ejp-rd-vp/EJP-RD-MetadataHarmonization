
module EJP
  module Schema
    class BioBank
        attr_accessor :id
        attr_accessor :recruiting 
        
        def initialize(params = {})
          SioHelper::General.setNamespaces()

          @name = params.fetch(:name, 'Some Person')
          
        end
      
    end
  end
end

