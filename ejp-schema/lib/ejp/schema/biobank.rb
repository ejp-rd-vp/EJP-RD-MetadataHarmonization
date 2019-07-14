
module EJP
  module Schema
    class BioBank < EJP::Schema::GenericRegistry
        attr_accessor :id
        attr_accessor :recruiting 
        attr_accessor :types
        
        def initialize(params = {})
          super
          
          
          SioHelper::General.setNamespaces()

          @name = params.fetch(:recruiting, '')
          
        end
      
    end
  end
end

