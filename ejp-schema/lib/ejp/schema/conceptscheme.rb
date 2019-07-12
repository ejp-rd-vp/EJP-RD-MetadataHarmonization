
module EJP
  module Schema

    class ConceptScheme
        attr_accessor :uri
        attr_accessor :title  
        attr_accessor :creator
        attr_accessor :concepts
        attr_accessor :graph
        attr_accessor :factory
        

        
        def initialize(params = {})
          SioHelper::General.setNamespaces()
          @uri = params.fetch(:uri, nil)
          abort "Cannot create an unnamed concept scheme - aborting" if @uri.nil?
          @factory = params.fetch(:factory, nil)
          abort "Cannot create a concept scheme without a factory - aborting" if @factory.nil?

          @graph = RDF::Graph.new
          
          @title = params.fetch(:title, "untitled")
          @creator = params.fetch(:url, "http://anonymous.anon")
          @concepts = []
          

        end
        
        def addConcept(concept)
          self.concepts << concept
        end
        
        def build()
          guid = self.uri
          f = self.factory
          g = self.graph
          title = self.title
    			creator = self.creator
    
          f.add_triples(g,[
              [guid, $rdf.type, $skos.ConceptScheme],
              [guid, $dct.title, title ],
              [guid, $dct.creator, creator ],
            ])


          return g
        end
        
        
    end
  end
end

