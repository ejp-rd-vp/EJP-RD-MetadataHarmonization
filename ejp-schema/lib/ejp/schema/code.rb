module EJP
  module Schema

  
	class Code
		attr_accessor :uri  # canonical, but also returns with #url
		attr_accessor :label
		attr_accessor :description
		attr_reader   :graph
		attr_reader   :factory
		attr_reader   :conceptscheme
		
		def initialize(params = {})
		  SioHelper::General.setNamespaces()
		  @graph = RDF::Graph.new
		  @factory = params.fetch(:factory, nil)
          abort "can't create a Code without a Factory" if @factory.nil?
		  
		  url = params.fetch(:url, "")
		  uri = params.fetch(:uri, "")
		  if uri =~ /^\w+\:\/\//
        self.uri = uri
		  elsif url =~ /^\w+\:\/\//
        self.uri = url
		  else
			warn "cannot create a non-named (no uri/url) code"
			return false
		  end

      @conceptscheme = params.fetch(:conceptscheme, nil)
          abort "can't create a Code without a ConceptScheme (this should never happen if you are using the schema factory)" if @conceptscheme.nil?

		  @label = params.fetch(:label, @uri.to_s)
		  @description = params.fetch(:description, 'No Description Provided')
		  
		  self.build
		  @conceptscheme.addConcept(self)
		  
		end
		
		def url  # convenience :-)
		  return self.uri
		end
		def url=(url)
		  self.uri = url
		end
		
		
		def build()  # fills the graph
			guid = self.uri
			label = self.label
			desc = self.description
			cs = self.factory.conceptscheme.uri
			f = self.factory
			g = self.graph
			
#ex:mammals rdf:type skos:Concept;
#  skos:inScheme ex:animalThesaurus.

			f.add_triples(g,[
				  [guid, $rdf.type, $skos.Concept ],
				  [guid, $skos.inScheme, cs],
				  [guid, $schema.description, desc ],
				  [guid, $rdfs.label, label.to_s ],
			])
			
			return g
		end
	end
  end
end
  
    