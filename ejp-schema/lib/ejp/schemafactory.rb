require "ejp/schema/version"
require 'sio_helper'
require 'rdf'
require 'rdf/turtle'
require 'uuidtools'
require "ejp/schema/code"
require "ejp/schema/codingsystem"
require "ejp/schema/propertyvalue"
require "ejp/schema/organization"
require "ejp/schema/datetime"
require "ejp/schema/location"
require "ejp/schema/eupid"
require "ejp/schema/conceptscheme"
require "ejp/schema/catalog"
require "ejp/schema/genericregistry"
require "ejp/schema/patientregistry"
require "ejp/schema/biobank"
require "ejp/schema/studydesign"
require "ejp/schema/biologicalsample"
require "ejp/schema/patient"


module EJP
  class SchemaFactory
    attr_accessor :baseuri
    attr_accessor :conceptscheme
    attr_accessor :helper
    attr_accessor :top_catalog
#    attr_accessor :datasets
    
    def initialize(params = {})
          #super(params)  
          
          SioHelper::General.setNamespaces()

          uuid = UUIDTools::UUID.timestamp_create
          @helper =  SioHelper::SioHelper.new
          @baseuri = params.fetch(:baseuri,  $example[uuid])
          @conceptscheme = EJP::Schema::ConceptScheme.new(uri: self.baseuri + "#ConceptScheme",
                                                          title: "SKOS Concept Scheme for Registry #{uuid}",
                                                          creator: "https://github.com/ejp-rd-vp/EJP-RD-MetadataHarmonization/tree/master/ejp-schema",
                                                          factory: self)
          @top_catalog = nil
          
    end
    
    
    
    
    def createCatalog(params)
      
      if !self.top_catalog.nil?
        warn "cannot create a new Catalog from this factory.  You must create a new factory object to do this"
        return false
      end
      
      uri = params.fetch(:uri, nil )
      unless uri
        uri = self.baseuri + "#Catalog"
      end
      types = params.fetch(:types, []
                           )
      types = [types] unless types.is_a?(Array)
      (types << [$dcat.Catalog, $sio.catalog, $schema.CreativeWork, $ejp.Catalog]).flatten!
      top = EJP::Schema::Catalog.new(params.merge(
                  factory: self,
                  uri: uri,
                  types: types,
                  conceptscheme: self.conceptscheme))
      self.top_catalog = top
      return top
    end
    


    def createPatientRegistry(params)
      
      uuid = UUIDTools::UUID.timestamp_create

      uri = params.fetch(:uri, nil )
      unless uri
        uri = self.baseuri + "#PatientRegistry_" + uuid
      end
      types = params.fetch(:types, ["http://purl.obolibrary.org/obo/NCIT_C61393",
                                    "http://purl.allotrope.org/ontologies/result#AFR_0001059"]
                           )
      types = [types] unless types.is_a?(Array)
      (types << [$dcat.Dataset, $sio.dataset, $schema.CreativeWork, $ejp.Dataset, $ejp.PatientRegistry]).flatten!
      top = EJP::Schema::PatientRegistry.new(params.merge(
                  factory: self,
                  uri: uri,
                  types: types,
                  conceptscheme: self.conceptscheme))
      self.top_catalog = top
      return top
    end
    
    
    
    
    
    
    def createBioBank(params)
      uuid = UUIDTools::UUID.timestamp_create
      uri = params.fetch(:uri, nil )
      unless uri
        uri = self.baseuri + "#BioBank_" + uuid
      end
      types = params.fetch(:types, ["http://purl.obolibrary.org/obo/OMIABIS_0000000",
                                    "http://edamontology.org/topic_3337"]
                     )
      types = [types] unless types.is_a?(Array)
      (types << [$dcat.Dataset, $sio.dataset, $schema.CreativeWork, $ejp.Dataset, $ejp.BioBank]).flatten!
      top =  EJP::Schema::BioBank.new(params.merge(
                  factory: self,
                  uri: uri,
                  types: types,
                  conceptscheme: self.conceptscheme))
      
      return top
    end




    
    def createStudyDesign()
    end
    




    def createBiologicalSample(params)
      types = params.fetch(:types, ["http://semanticscience.org/resource/sample",
                                    "http://purl.obolibrary.org/obo/OBI_0000671"] ) #sample
      types = [types] unless types.is_a?(Array)
      (types << [$dcat.Dataset, $sio.dataset, $schema.CreativeWork, $ejp.Dataset]).flatten!

      
      uri = params.fetch(:uri, nil )
      uuid = UUIDTools::UUID.timestamp_create

      unless uri
        uri = self.baseuri + "/BiologicalSample_" + uuid
      end

      return EJP::Schema::BiologicalSample.new(params.merge(
                  factory: self,
                  uri: uri,
                  types: types,
                  ))
      
    end
    
    
    
    
    
    def createPatient()
      types = params.fetch(:types, ["http://semanticscience.org/resource/patient",
                                    "http://purl.obolibrary.org/obo/OAE_0001817",
                                    "http://purl.obolibrary.org/obo/NCIT_C16960",
                                    "http://purl.obolibrary.org/obo/ico.owl/ICO_0000321",
                                    ] ) #sample
      types = [types] unless types.is_a?(Array)
      (types << [$dcat.Dataset, $sio.dataset, $schema.CreativeWork, $ejp.Dataset]).flatten!
      
            
      uri = params.fetch(:uri, nil )
      uuid = UUIDTools::UUID.timestamp_create

      unless uri
        uri = self.baseuri + "/Patient_" + uuid
      end

      return EJP::Schema::Patient.new(params.merge(
                  factory: self,
                  uri: uri,
                  types: types,
                  ))
    end
    
    
    
    
    
    
    def createCode(params)
      return EJP::Schema::Code.new(params.merge({
                  factory: self,
                  conceptscheme: self.conceptscheme}))
      
    end
    
    
    
    
    def createCodingSystem()
    end
    
    
    
    
    
    def createPropertyValue()
    end
    
    
    
    
    
    
    def createOrganization(params)
      uuid = UUIDTools::UUID.timestamp_create

      return EJP::Schema::Organization.new(params.merge({
        factory: self,
        uri: self.baseuri + "#Organization_" + uuid
      }))
    end
    
    
    
    
    
    def createDateTime()
    end
    
    
    
    
    
    def createLocation(params)
      uuid = UUIDTools::UUID.timestamp_create

      return EJP::Schema::Location.new(params.merge({
        factory: self,
        uri: self.baseuri + "#Org_Location_" + uuid
      }))
    end
    
    
    
    
    
    def createEUPID()
    end
    
                    
                    
                    
                    
                    
    def add_triples(graph, triples)
      # note that triples might be an RDF::Graph... it's fine with .each
      helper = self.helper
      triples.each do |t|
        if t.is_a?(Array)
          s, p, o = t
        elsif t.is_a?(RDF::Statement)
          
          s, p, o = t.subject, t.predicate, t.object
        else
          abort "you can only pass arrays of s.p.o or a rdf statement to add_triples"
        end
        #$stderr.puts s,p,o,"end"
        helper.triplify(s,p,o,graph)
      end
      return graph
    end






  end
end
