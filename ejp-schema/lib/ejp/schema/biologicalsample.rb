

module EJP
  module Schema

    class BiologicalSample
        attr_accessor :id  
        attr_accessor :name
        attr_accessor :description
        attr_accessor :inCatalog
        attr_accessor :characteristic
        
        def initialize(params = {})
          SioHelper::General.setNamespaces()
          
          @name = params.fetch(:name, 'Some Person')
          
        end
      
    end
  end
end
