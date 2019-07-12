

module EJP
  module Schema
    
    class PropertyValue
        attr_accessor :id  
        attr_accessor :name
        attr_accessor :value
        attr_accessor :code
        
        def initialize(params = {})
          SioHelper::General.setNamespaces()
          
          @name = params.fetch(:name, 'Some Property')
          
        end
    end
  end
end

