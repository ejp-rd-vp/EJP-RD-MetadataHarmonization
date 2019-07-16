
module EJP
  module Schema
    class BioBank < EJP::Schema::GenericRegistry
        attr_accessor :recruiting 
        attr_accessor :graph 
        attr_accessor :factory 
        
        def initialize(params = {})
          super
          
          @graph = RDF::Graph.new
          @factory = params.fetch(:factory, nil)
            abort 'cannot create a BioBank without a factory' if @factory.nil?


          @recruiting = params.fetch(:recruiting, '')
          
        end
        
        
        def build
          SioHelper::General.setNamespaces()
          parentgraph = super.build
          g = self.graph
          f = self.factory
          f.addTriples(g, parentgraph)
          f.add_triples(g, [
                  [self.uri, $ejp.recruiting]])
        end
        
          
      
    end
  end
end

