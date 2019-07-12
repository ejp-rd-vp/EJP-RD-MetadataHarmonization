
module EJP
  module Schema
	class Catalog 
        attr_accessor :factory  # parent SchemaFactory
        attr_reader :uri  
        attr_accessor :alternateName # string
        attr_accessor :about # Array of Code objects
        attr_accessor :name # string
        attr_accessor :title # string
        attr_accessor :description # string
        attr_accessor :homepage # string
        attr_accessor :sameAs # Array of string
        attr_accessor :license # string (should be URL)
        attr_accessor :creator #  EJP::Schema::Organization
        attr_accessor :dataset  # Array of  EJP::Schema::Dataset
        attr_reader :graph  # RDF::Graph
        
        def initialize(params = {})
          #super(params)
		  @graph = RDF::Graph.new()
		  @factory = params.fetch(:factory, nil)
          abort "can't create a Catalog without a Factory" if @factory.nil?

          
          SioHelper::General.setNamespaces()


          @uri = params.fetch(:uri)
          abort "can't create a catalog without a URI identifier" unless @uri.to_s =~ /^\w+\:\/\//
          @alternateName  = params.fetch(:alternateName, [])
          @alternateName = [@alternateName] unless @alternateName.is_a? Array
          
          @about  = params.fetch(:about, [])
          @about = [@about] unless @about.is_a? Array
          
          @name = params.fetch(:name, 'Unidentified Catalog')
          @title = params.fetch(:title, "")
          @name = @title if !@title.nil?  # title takes precedence
          
          @description = params.fetch(:description, 'No description provided')
          @homepage = params.fetch(:homepage, "")
          @sameAs = params.fetch(:sameAs, [])
          @sameAs = [@sameAs] unless @sameAs.is_a? Array
          
          @license = params.fetch(:license, "")
          @creator  = params.fetch(:creator, "")
          @dataset = params.fetch(:dataset, [])
          
          @about.each do |a|
            self.addCode(a)
          end

          if !@creator.empty? & !@creator.is_a?(EJP::Schema::Organization)
              warn "removing location #{@creator} because it is not an EJP::Schema::Organization object"
              @location = nil
          end
          
          dataset.each do |a|
            unless a.is_a? EJP::Schema::Registry
              @about.remove(a)
              warn "removing #{a} from the list of datasets because it is not an EJP::Schema::Registry object"
            end
          end

          
          self.build
          
        end




		def addAbout(code)
			unless a.is_a? EJP::Schema::Code
			  warn "Ignoring this code (#{a.to_s}), because it is not an EJP::Schema::Code object"
			else
			  @factory.conceptscheme.addConcept(a)
			end
		end
		





        def build()
                    
          catalog = self
          f = self.factory
          g = self.graph
          
          f.add_triples(g, [
              [catalog.uri, $sio['has-identifier'], catalog.uri],
              [catalog.uri, $schema.identifier, catalog.uri],
              [catalog.uri, $rdf.type, $dcat.Catalog],
              [catalog.uri, $rdf.type, $sio.catalog],
              [catalog.uri, $rdf.type, $schema.CreativeWork],
              [catalog.uri, $rdf.type, $ejp.Catalog],
              [catalog.uri, $schema.name, catalog.name],
              [catalog.uri, $dct.title, catalog.name],
              [catalog.uri, $foaf.homepage, self.homepage],  
              [catalog.uri, $schema.description, self.description],
              [catalog.uri, $dct.description, self.description],
          ])
          
          catalog.alternateName.each do |a|
            f.add_triples(g, [
              [catalog.uri, $schema.alternateName, a ]
            ])
          end
          
          f.add_triples(g, [[catalog.uri, $dct.license, self.license]]) unless self.license.nil?
          
         
          self.about.each do |c|  # c = EJP::Schema::Code
            f.add_triples(g, c.graph)  # merge the code graph            
          end

          if !@creator.empty?
            
            f.add_triples(g, [            
                [catalog.uri, $schema.creator, "#{catalog.uri}#creator"],
                  ["#{catalog.uri}#creator", $rdf.type, $schema.Organization ],
                  ["#{catalog.uri}#creator", $schema.name, catalog.creator.name.to_s ],
                  ["#{catalog.uri}#creator", $schema.address, "#{catalog.uri}#creatoraddress" ],
                      ["#{catalog.uri}#creatoraddress", $schema.streetAddress, catalog.creator.address.street.to_s ],
                      ["#{catalog.uri}#creatoraddress", $schema.addressCountry, catalog.creator.address.city.to_s ],
                      ["#{catalog.uri}#creatoraddress", $schema.addressLocality, catalog.creator.address.country.to_s ],
            ])
          end
          
          
          self.dataset.each do |d|  # d = EJP::Schema::Registry or Biobank
            f.add_triples(g, d)
          end

		  self.factory.conceptscheme.build # refresh
		  f.add_triples(g, self.factory.conceptscheme.graph)
		  
		  return g  # not strictly necessary, since it's part of this object, but...
        
        end
        
	end
  end
end