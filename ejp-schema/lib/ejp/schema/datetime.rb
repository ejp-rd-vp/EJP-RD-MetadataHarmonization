

module EJP
  module Schema
    
    class DateTime
        attr_accessor :id  
        attr_accessor :day
        attr_accessor :month
        attr_accessor :year
        attr_accessor :time
        
        def initialize(params = {})
          SioHelper::General.setNamespaces()
          
          @name = params.fetch(:day, 'Mooonday')
          
        end
    end
  end
end
