

module EJP
  module Schema
    
    class Location
        attr_accessor :street  
        attr_accessor :city
        attr_accessor :code
        attr_accessor :country
        attr_accessor :graph
        attr_reader :factory
        attr_reader :uri
        
        def initialize(params = {})
          SioHelper::General.setNamespaces()
          @graph = RDF::Graph.new
          @uri = params.fetch(:uri, nil)
          abort 'cannot create a location without a uri' if @uri.nil?
          @factory = params.fetch(:factory, nil)
          abort 'cannot create a location without a factory' if @factory.nil?
          
          @street = params.fetch(:street, "")
          @city = params.fetch(:city, "")
          @code = params.fetch(:code, "")
          @country = params.fetch(:country, "")
          
          self.build
          
        end
        
        def build
            f = self.factory
            g = self.graph
            
            f.add_triples(g, [
                    [self.uri, $schema.streetAddress, self.street.to_s ],
                    [self.uri, $schema.addressCountry, self.country.to_s ],
                    [self.uri, $schema.addressLocality,self.city.to_s ],
                    [self.uri, $sio['postal-code'],self.code.to_s ],
                  ])
            return g
        end
    end
  end
end

