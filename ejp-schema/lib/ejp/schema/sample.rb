
module EJP
  module Schema
    class Sample
          attr_accessor :uri
          attr_accessor :identifier
          attr_accessor :name
          attr_accessor :description
          attr_accessor :characteristic  # array of prop values
          attr_accessor :inCatalog
          attr_accessor :landingPage
          attr_accessor :contactPoint
          attr_accessor :themes  # array of codes
          attr_accessor :types
          attr_accessor :graph
          attr_accessor :factory
          
          def initialize(params = {})
                 
            SioHelper::General.setNamespaces()
            
            @graph = RDF::Graph.new()
            @factory = params.fetch(:factory, nil)
            abort "can't create a Sample/Patient without a Factory" if @factory.nil?
            @uri = params.fetch(:uri)
            abort "can't create a Sample/Patient without a URI identifier" unless @uri.to_s =~ /^\w+\:\/\//
            @identifier = params.fetch(:identifier, nil)
            abort "can't create a Sample/Patient without a local unique identifier" if @identifier.nil?

            @types = []  # may be want to add some defaults here...
            types = params.fetch(:types, [])
            types = [types] unless types.is_a?(Array)
            types.each do |t|
              @types << t
            end

            @name = params.fetch(:name, 'Unidentified Sample')
            @description = params.fetch(:description, "")
            @landingPage = params.fetch(:landingPage, "")
            @characteristic = params.fetch(:characteristic, [])
            @characterlistc = [@characteristic] unless @characteristic.is_a?(Array)
            @contactPoint = params.fetch(:contactPoint, "no contact named")
            @graph = RDF::Graph.new()

            @themes = params.fetch(:themes, [])
            @themes = [@themes] unless @themes.is_a?(Array)
            @themes.each do |code|
              unless code.is_a?(EJP::Schema::Code)
                warn "Ignoring this theme (#{code.to_s}), because it is not an EJP::Schema::Code object"
                @themes.delete(code)
              end
            end

            self.build
  
          end
          
  
  
          def build()
            SioHelper::General.setNamespaces()

            dataset = self
            f = self.factory
            g = self.graph


            self.types.each do |t|
              f.add_triples(g, [
                  [dataset.uri, $rdf.type, t.to_s]]
                           )
            end

            f.add_triples(g, [
                  [dataset.uri, $ejp.inCatalog, f.top_catalog.uri]]
                           )
            
            f.add_triples(g, [
                [dataset.uri, $sio['has-identifier'], dataset.uri],
                [dataset.uri, $schema.identifier, dataset.uri],
                [dataset.uri, $sio['has-identifier'], dataset.identifier],
                [dataset.uri, $schema.identifier, dataset.identifier],
                [dataset.uri, $schema.name, dataset.name],
                [dataset.uri, $dct.title, dataset.name],
                [dataset.uri, $foaf.homepage, self.landingPage],  
                [dataset.uri, $dcat.landingPage, self.landingPage],  
                [dataset.uri, $dcat.contactPoint, self.contactPoint],  
                [dataset.uri, $schema.description, self.description],
                [dataset.uri, $dct.description, self.description],
            ])
            

            
            themes = Array.new
            dataset.themes.each do |t|
              themes.concat([dataset.uri, $dcat.theme, t.uri]) 
            end
            f.add_triples(g, [themes])
                    
            return g
          
          end
        
    end  
  end
end