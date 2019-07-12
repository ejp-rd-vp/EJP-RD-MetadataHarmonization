
module EJP
  module Schema
	class Registry
        attr_accessor :uri 
        attr_accessor :studyDesign 
        attr_accessor :hasBioBank
        attr_accessor :inBioBank
        attr_accessor :title
        attr_accessor :description
        attr_accessor :issued
        attr_accessor :modified
        attr_accessor :identifier
        attr_accessor :keyword
        attr_accessor :language
        attr_accessor :contactPoint
        attr_accessor :landingPage
        attr_accessor :theme
        attr_accessor :distribution
        attr_accessor :graph
        
        def initialize(params = {})
          # From Simon Jupp
          SioHelper::General.setNamespaces()
          @ejp =  RDF::Vocabulary.new("http://www.ejprarediseases.org/resources/ontology#")


          @uri = params.fetch(:uri, nil)
          @studyDesign = params.fetch(:studyDesign, nil)
          @hasBioBank = params.fetch(:hasBioBank, false)
          @inBioBank = params.fetch(:inBioBank, nil)
          # from DCAT Dataset
          
          @description = params.fetch(:description, "")
          @issued = params.fetch(:issued, "")
          @modified = params.fetch(:modified, "")
          @identifier = params.fetch(:identifier, [])
          @identifier = [@identifier] unless @identifier.is_a? Array

          @keyword = params.fetch(:keyword, [])
          @keyword = [@keyword] unless @keyword.is_a? Array
          
          @language = params.fetch(:language, 'en')
          @contactPoint = params.fetch(:contactPoint, "")
          @landingPage = params.fetch(:landingPage, "")
          @theme = params.fetch(:theme, [])
          @theme = [@theme] unless @theme.is_a? Array
          @distribution = params.fetch(:distribution, [])
          
          
          @name = params.fetch(:name, 'Unidentified Registry')
          @title = params.fetch(:title, nil)
          @name = @title if !@title.nil?  # title takes precedence, use "name" throughout
          
          @graph = RDF::Graph.new()

        end
        
        def add_metadata(triples)
          helper = SioHelper::SioHelper.new
          triples.each do |t|
            s, p, o = t
            helper.triplify(s,p,o,self.graph)
          end
        end


        def build()
          self.setNamespaces()
        #attr_accessor :studyDesign 
        #attr_accessor :inBioBank
        #attr_accessor :distribution
        #
          
          registry = self
          
          themes = Array.new
          registry.theme.each do |t|
            themes.concat([[registry.uri, dcat.theme, t],
              [t, rdf.type, skos.Concept]]) 
          end

          keywords = Array.new
          registry.keyword.each do |t|
            keywords.concat([[registry.uri, dcat.keyword, t]])
          end

          self.add_metadata([
              [registry.uri, @sio['has-identifier'], registry.uri],
              [registry.uri, @schema.identifier, registry.uri],
              [registry.uri, @rdf.type, @dct.Dataset],
              [registry.uri, @rdf.type, @ejp.Registry],
              [registry.uri, @rdf.type, @schema.CreativeWork],
              [registry.uri, @rdf.type, "http://purl.obolibrary.org/obo/ERO_0001843"], # registry
                 ["http://purl.obolibrary.org/obo/ERO_0001843", rdfs.label, "Registry"],
              [registry.uri, @schema.name, registry.name],
              [registry.uri, @dct.title, registry.name],
              [registry.uri, @dct.language, registry.language],
              [registry.uri, @foaf.landingPage, registry.landingPage],  
              [registry.uri, @schema.description, registry.description],
              [registry.uri, @dct.description, registry.description],
              [registry.uri, @dcat.contactPoint, registry.contactPoint],
              [registry.uri, @dct.issued, registry.issued],
              [registry.uri, @dct.modified, registry.modified],
              [registry.uri, @ejp.hasBioBank, registry.hasBioBank],
              # Add each theme
              themes.flatten!,
              # Add each keyword
              keywords.flatten!,
              
              
          ])
          registry.identifier.each do |i|
              self.add_metadata([[registry.uri, @schema.identifier, i.to_s]])
              self.add_metadata([[registry.uri, @sio['has-identifier'], registry.uri]])
          end
          
          registry.distribution.each do |d|
              self.add_metadata([[registry.uri, @dcat.distribution, d.to_s]])
          end
          
          
        end
      
	end
    
    
  end
end