

module EJP
  module Schema
    
    class Organization

        attr_accessor :name
        attr_accessor :facility
        attr_accessor :department
        attr_accessor :street
        attr_accessor  :city
        attr_accessor :country
        attr_accessor :code
        attr_reader :address  # EJP::Schema::Location
        attr_reader :uri
        attr_reader :factory
        attr_reader :graph
        
        def initialize(params = {})
          SioHelper::General.setNamespaces()
          @graph = RDF::Graph.new
          @uri = params.fetch(:uri, nil)
            abort 'cannot create a Organization without a uri' if @uri.nil?
          @factory = params.fetch(:factory, nil)
            abort 'cannot create a Orgnization without a factory' if @factory.nil?
		  

          @name = params.fetch(:name, 'Organization Name Not Provided')
          @facility = params.fetch(:facility, "")
          @department = params.fetch(:department, "")
          @street = params.fetch(:street, "")
          @city = params.fetch(:city, "")
          @code = params.fetch(:code, "")
          @country = params.fetch(:country, "")
          location = @factory.createLocation(street: @street,
                                             city: @city,
                                             code: @code,
                                             country: @country)
          @address = location
          
          self.build
        end
        
        
        def build
          f = self.factory
          g = self.graph
          
            f.add_triples(g, [
                      [self.uri, $rdf.type, $schema.Organization ],
                      [self.uri, $schema.name, self.name ],
                      [self.uri, $ejp.facility, self.facility ],
                      [self.uri, $ejp.department, self.department ],
                      [self.uri, $schema.address, @address.uri ],
                      ])
            @address.build
            f.add_triples(g, @address.graph)
        end
        

    end
  end
end

