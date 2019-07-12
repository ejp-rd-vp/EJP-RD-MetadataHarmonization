

module EJP
  module Schema
    
    class Location
        attr_accessor :street  
        attr_accessor :city
        attr_accessor :code
        attr_accessor :country
        
        def initialize(params = {})
          SioHelper::General.setNamespaces()
          
          @street = params.fetch(:street, "")
          @city = params.fetch(:@city, "")
          @code = params.fetch(:@code, "")
          @country = params.fetch(:@country, "")
          
        end
    end
  end
end

