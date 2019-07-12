require "ejp/schema/version"
require 'sio_helper'
require 'rdf'
require 'rdf/turtle'
require 'uuidtools'
require "ejp/schema/catalog"
require "ejp/schema/registry"
require "ejp/schema/biobank"
require "ejp/schema/studydesign"
require "ejp/schema/biologicalsample"
require "ejp/schema/patient"
require "ejp/schema/code"
require "ejp/schema/codingsystem"
require "ejp/schema/propertyvalue"
require "ejp/schema/organization"
require "ejp/schema/datetime"
require "ejp/schema/location"
require "ejp/schema/eupid"
require "ejp/schema/conceptscheme"


module EJP
  class SchemaFactory
    attr_accessor :baseuri
    attr_accessor :conceptscheme
    
    def initialize(params = {})
          #super(params)  
          
          SioHelper::General.setNamespaces()

          uuid = UUIDTools::UUID.timestamp_create
          @baseuri = params.fetch(:baseuri,  $example[uuid])
          @conceptscheme = EJP::Schema::ConceptScheme.new(uri: self.baseuri + "#ConceptScheme",
                                                          title: "SKOS Concept Scheme for Catalog #{uuid}",
                                                          creator: "https://github.com/ejp-rd-vp/EJP-RD-MetadataHarmonization/tree/master/ejp-schema",
                                                          factory: self)
    end
    
    def createCatalog(args)
      return EJP::Schema::Catalog.new(args.merge(
                  factory: self,
                  uri: self.baseuri,
                  conceptscheme: self.conceptscheme))
    end
    
    def createRegistry()
    end
    
    def createBiobank()
    end
    
    def createStudyDesign()
    end
    
    def createBiologicalSample()
    end
    
    def createPatient()
    end
    
    def createCode()
    end
    
    def createCodingSystem()
    end
    
    def createPropertyValue()
    end
    
    def createOrganization()
    end
    
    def createDateTime()
    end
    
    def createLocation()
    end
    
    def createEUPID()
    end
    
                    
    def add_triples(graph, triples)
      # note that triples might be an RDF::Graph... it's fine with .each
      helper = SioHelper::SioHelper.new
      triples.each do |t|
        s, p, o = t
        helper.triplify(s,p,o,graph)
      end
      return graph
    end

  end
end
