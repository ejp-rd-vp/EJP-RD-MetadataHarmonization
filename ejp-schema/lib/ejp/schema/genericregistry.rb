
module EJP
  module Schema
      class GenericRegistry 
            attr_accessor :factory  # parent SchemaFactory
            attr_reader   :uri  
            attr_accessor :alternateName # string
            attr_accessor :about # Array of Code objects
            attr_accessor :name # string
            attr_accessor :title # string
            attr_accessor :description # string
            attr_accessor :homepage # string
            attr_accessor :sameAs # Array of string
            attr_accessor :license # string (should be URL)
            attr_reader   :publisher #  EJP::Schema::Organization
            attr_reader   :datasets  # Array of  EJP::Schema::Dataset
            attr_reader   :graph  # RDF::Graph
            attr_reader   :types # ARRAY  of strings
            
            def initialize(params = {})
              
              @graph = RDF::Graph.new()
              @factory = params.fetch(:factory, nil)
              abort "can't create a Registry without a Factory" if @factory.nil?
    
              
              SioHelper::General.setNamespaces()
              
              @types = []
              types = params.fetch(:types, [])
              types = [types] unless types.is_a?(Array)
              types.each do |t|
                @types << t
              end

    
              @uri = params.fetch(:uri)
              abort "can't create a Registyry without a URI identifier" unless @uri.to_s =~ /^\w+\:\/\//
              @alternateName  = params.fetch(:alternateName, [])
              @alternateName = [@alternateName] unless @alternateName.is_a? Array
              
              @about  = params.fetch(:about, [])
              @about = [@about] unless @about.is_a? Array
              
              @name = params.fetch(:name, 'Unidentified Registry')
              @title = params.fetch(:title, "")
              @name = @title if !@title.nil?  # title takes precedence
              
              @description = params.fetch(:description, 'No description provided')
              @homepage = params.fetch(:homepage, "")
              @sameAs = params.fetch(:sameAs, [])
              @sameAs = [@sameAs] unless @sameAs.is_a? Array
              
              @license = params.fetch(:license, "")
              @publisher  = params.fetch(:publisher, nil)
              @datasets = params.fetch(:dataset, [])
              @datasets = [@datasets] unless @datasets.is_a? Array
              
              @about.each do |a|
                self.addAbout(a)
              end
    
              if !@publisher.is_a?(EJP::Schema::Organization)
                  warn "removing organization #{@publisher} because it is not an EJP::Schema::Organization object"
                  @location = nil
              end
              
              #datasets.each do |a|
              #  unless a.is_a? EJP::Schema::Sample
              #    @about.remove(a)
              #    warn "removing #{a} from the list of datasets because it is not an EJP::Schema::Registry object"
              #  end
              #end
    
              
              self.build
              
            end
    
    
    
    
            def addAbout(code)
              unless code.is_a? EJP::Schema::Code
                warn "Ignoring this code (#{code.to_s}), because it is not an EJP::Schema::Code object"
              else
                @factory.conceptscheme.addConcept(code)
              end
            end
            
    
    
    
            #def addDataset(ds)
            #  unless ds.is_a? EJP::Schema::BiologicalSample
            #    warn "Ignoring this dataset (#{ds.to_s}), because it is not an EJP::Schema::BiologicalSample or Patient object"
            #  else
            #    
            #    @datasets << ds
            #
            #  end
            #    
            #end
            
    
    


            def build()
                        
              #dataset = self
              f = self.factory
              g = self.graph


              self.types.each do |t|
                f.add_triples(g, [
                    [self.uri, $rdf.type, t.to_s]]
                             )
              end

              
              f.add_triples(g, [
                  [self.uri, $sio['has-identifier'], self.uri],
                  [self.uri, $schema.identifier, self.uri],
                  [self.uri, $schema.name, self.name],
                  [self.uri, $dct.title, self.name],
                  [self.uri, $foaf.homepage, self.homepage],  
                  [self.uri, $schema.description, self.description],
                  [self.uri, $dct.description, self.description],
              ])
              
              self.alternateName.each do |a|
                f.add_triples(g, [
                  [self.uri, $schema.alternateName, a ]
                ])
              end
              
              f.add_triples(g, [[self.uri, $dct.license, self.license]]) unless self.license.nil?
              
             
              self.about.each do |c|  # c = EJP::Schema::Code
                f.add_triples(g, [            
                    [self.uri, $iao['IAO_0000136'], c.uri],  # is about from IAO
                    [self.uri, $dcat.theme, c.uri]  # is about from IAO
                    ])
                f.add_triples(g, c.graph)  # merge the code graph            
              end
    
              if !self.publisher.nil?
                self.publisher.build
                f.add_triples(g, [            
                      [self.uri, $schema.creator, self.publisher.uri],
                      [self.uri, $dct.publisher, self.publisher.uri]
                      ])
                f.add_triples(g, self.publisher.graph)  # this will auto-build the location object too
              end
              
    
              #self.factory.conceptscheme.build # refresh
              #csgraph = self.factory.conceptscheme.graph
              ##binding.pry
              #f.add_triples(g, [            
              #      [self.uri, $dcat.themeTaxonomy, self.factory.conceptscheme.uri]
              #      ])
              #f.add_triples(g, csgraph)
          
              
              #self.datasets.each do |d|
              #  d.build
              # 
              #  dsgraph = d.graph
              #  f.add_triples(g, [            
              #      [self.uri, $dcat.dataset, d.uri]
              #  ])
              #  f.add_triples(g, dsgraph)
              #end
              
              return g
            
            end
        
      end
  end
end