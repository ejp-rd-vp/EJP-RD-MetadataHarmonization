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


module EJP
  class SchemaFactory
    attr_accessor :baseuri
    
    def initialize(params = {})
          #super(params)  
          
          SioHelper::General.setNamespaces()

          uuid = UUIDTools::UUID.timestamp_create
          @baseuri = params.fetch(:baseuri,  $example[uuid])
    end
    
    def createCatalog(args)
      return EJP::Schema::Catalog.new(args.merge(uri: self.baseuri))
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
    
  end
end
