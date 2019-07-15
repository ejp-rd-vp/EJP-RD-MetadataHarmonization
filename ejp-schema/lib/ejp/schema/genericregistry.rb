
module EJP
  module Schema
      class GenericRegistry 
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
            attr_reader   :creator #  EJP::Schema::Organization
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
              @creator  = params.fetch(:creator, nil)
              @datasets = params.fetch(:dataset, [])
              @datasets = [@datasets] unless @datasets.is_a? Array
              
              @about.each do |a|
                self.addAbout(a)
              end
    
              if !@creator.is_a?(EJP::Schema::Organization)
                  warn "removing organization #{@creator} because it is not an EJP::Schema::Organization object"
                  @location = nil
              end
              
              datasets.each do |a|
                unless a.is_a? EJP::Schema::Sample
                  @about.remove(a)
                  warn "removing #{a} from the list of datasets because it is not an EJP::Schema::Registry object"
                end
              end
    
              
              self.build
              
            end
    
    
    
    
            def addAbout(code)
              unless code.is_a? EJP::Schema::Code
                warn "Ignoring this code (#{code.to_s}), because it is not an EJP::Schema::Code object"
              else
                @factory.conceptscheme.addConcept(code)
              end
            end
            
    
    
    
            def addDataset(ds)
              unless ds.is_a? EJP::Schema::BiologicalSample
                warn "Ignoring this dataset (#{ds.to_s}), because it is not an EJP::Schema::BiologicalSample or Patient object"
              else
                $stderr.puts "Adding dataset..."
                @datasets << ds
                $stderr.puts "@datasets #{@datasets.count}"
                $stderr.puts "self.datasets #{self.datasets.count}"
                
              end
                $stderr.puts "self.datasets #{self.datasets.count}"
            end
            
    
    


            def build()
              $stderr.puts "build self.datasets #{self.datasets.count}"
          
              dataset = self
              f = self.factory
              g = self.graph


              self.types.each do |t|
                f.add_triples(g, [
                    [dataset.uri, $rdf.type, t.to_s]]
                             )
              end

              
              f.add_triples(g, [
                  [dataset.uri, $sio['has-identifier'], dataset.uri],
                  [dataset.uri, $schema.identifier, dataset.uri],
                  [dataset.uri, $schema.name, dataset.name],
                  [dataset.uri, $dct.title, dataset.name],
                  [dataset.uri, $foaf.homepage, self.homepage],  
                  [dataset.uri, $schema.description, self.description],
                  [dataset.uri, $dct.description, self.description],
              ])
              
              dataset.alternateName.each do |a|
                f.add_triples(g, [
                  [dataset.uri, $schema.alternateName, a ]
                ])
              end
              
              f.add_triples(g, [[dataset.uri, $dct.license, self.license]]) unless self.license.nil?
              
             
              self.about.each do |c|  # c = EJP::Schema::Code
                f.add_triples(g, [            
                    [self.uri, $iao['IAO_0000136'], c.uri]  # is about from IAO
                    ])
                f.add_triples(g, c.graph)  # merge the code graph            
              end
    
              if !@creator.nil?
                org = @creator
                org.build
                f.add_triples(g, [            
                      [self.uri, $schema.creator, org.uri]
                      ])
                f.add_triples(g, org.graph)  # this will auto-build the location object too
              end
              
    
              self.factory.conceptscheme.build # refresh
              csgraph = self.factory.conceptscheme.graph
              #binding.pry
              f.add_triples(g, [            
                    [self.uri, $dcat.themeTaxonomy, org.uri]
                    ])
              f.add_triples(g, csgraph)
          
              $stderr.puts "Numbe of datasets #{self.datasets.count}"
              self.datasets.each do |d|
                d.build
                $stderr.puts "BUILDING....\n\n\n"
                dsgraph = d.graph
                f.add_triples(g, [            
                    [self.uri, $dcat.dataset, d.uri]
                ])
                f.add_triples(g, dsgraph)
              end
              return g  # not strictly necessary, since it's part of this object, but...
            
            end
        
      end
  end
end