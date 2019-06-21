require "ejp/schema/version"
require 'sio_helper'
require 'ejp/ldp_object'
require 'rdf'
require 'rdf/turtle'

module EJP
  module Schema
    class Error < StandardError; end

    class Catalog < EJP::LDPServer
        attr_accessor :id  
        attr_accessor :alternateName
        attr_accessor :about
        attr_accessor :name
        attr_accessor :description
        attr_accessor :homepage
        attr_accessor :sameAs
        attr_accessor :location
        
        def initialize(params = {})
          super(params)  
          
          @id = params.fetch(:id, nil)
          @alternateName  = params.fetch(:alternateName, [])
          @about  = params.fetch(:about, [])
          @name = params.fetch(:name, 'Unidentified Catalog')
          @description = params.fetch(:description, 'No description provided')
          @homepage = params.fetch(:homepage, nil)
          @sameAs = params.fetch(:sameAs, [])
          @location = params.fetch(:location, nil)
          
          @about.each do |a|
            unless a.is_a? EJP::Schema::Code
              @about.remove(a)
              warn "removing #{a} because it is not an EJP::Schema::Code object"
            end
          end

          unless @location.is_a? EJP::Schema::Location
              warn "removing location #{@location} because it is not an EJP::Schema::Location object"
              @location = nil
          end
          
          @graph = RDF::Graph.new()
          @helper = SioHelper::SioHelper.new
          
        end
        
        def add_metadata
        
        end
        
        def build()
          self.setNamespaces()
          #@id = params.fetch(:id, nil)
          #@alternateName  = params.fetch(:alternateName, [])
          #@about  = params.fetch(:about, [])
          #@name = params.fetch(:name, 'Unidentified Catalog')
          #@description = params.fetch(:description, 'No description provided')
          #@homepage = params.fetch(:homepage, nil)
          #@sameAs = params.fetch(:sameAs, [])
          #@location = params.fetch(:location, nil)

          
          catalog = self
          self.add_metadata([
              [catalog.uri, @sio['has-identifier'], catalog.uri],
              [catalog.uri, @schema.identifier, @catalog.uri],
              [catalog.uri, @rdf.type, @dct.Catalog],
              [catalog.uri, @rdf.type, @schema.CreativeWork],
              [catalog.uri, @schema.name, "Mock Catalogue of EJP Registries and BioBanks"],
              [catalog.uri, @dct.title, "Mock Catalogue of EJP Registries and BioBanks"],
              [catalog.uri, @schema.alternateName, "Mark, Annika, Rajaram, Erik and Pablo exploring FAIR data transformation models for the EJP project"],
              [catalog.uri, @schema.description, "We have created 4 mock patient registries - CF, Duchenne, Addison, and Adiposis - and are exploring various FAIR models for those data, based on the proposed CDEs of the EUROPEAN PLATFORM ON RARE DISEASES REGISTRATION(EU RD Platform).  We are also exploring high level metadata structures, as proposed by Simon Jupp.  These are being modelled using the Linked Data Platform as an overarching metadata schema."],
              [catalog.uri, @dct.description, "We have created 4 mock patient registries - CF, Duchenne, Addison, and Adiposis - and are exploring various FAIR models for those data, based on the proposed CDEs of the EUROPEAN PLATFORM ON RARE DISEASES REGISTRATION(EU RD Platform).  We are also exploring high level metadata structures, as proposed by Simon Jupp.  These are being modelled using the Linked Data Platform as an overarching metadata schema."],
              [catalog.uri, @dct.license, "CC-BY-4.0"],
              
               [catalog.uri, @schema.about, "#{catalog.uri}#code1"],
                ["#{catalog.uri}#code1", @rdf.type, Code ],
                ["#{catalog.uri}#code1", @sio['has-identifier'], 'http://umbel.org/umbel#Diseases'],
                ["#{catalog.uri}#code1", @schema.url, 'http://umbel.org/umbel#Diseases' ],
                ["#{catalog.uri}#code1", @rdfs.label, "Diseases" ],
                ["#{catalog.uri}#code1", @schema.description, "Diseases are atypical or unusual or unhealthy conditions for (mostly human) living things, generally known as conditions, disorders, infections, diseases or syndromes. Diseases only affect living things and sometimes are caused by living things." ],
              
              [catalog.uri, @foaf.homepage, "https://github.com/LUMC-BioSemantics/ERN-common-data-elements"],  
              [catalog.uri, @schema.creator, "#{catalog.uri}#creator"],
                ["#{catalog.uri}#creator", @rdf.type, @schema.Organization ],
                ["#{catalog.uri}#creator", @schema.name, "Leiden University Medical Center" ],
                ["#{catalog.uri}#creator", @schema.address, "#{catalog.uri}#creatoraddress" ],
                    ["#{catalog.uri}#creatoraddress", @schema.streetAddress, "S4-P/building 2, PO Box 9600" ],
                    ["#{catalog.uri}#creatoraddress", @schema.addressCountry, "NL" ],
                    ["#{catalog.uri}#creatoraddress", @schema.addressLocality, "Leiden" ],
          ]) 
  
  
        end
        
      
    end
  
    class Registry
        attr_accessor :id 
        attr_accessor :studyDesign 
        attr_accessor :hasBioBank
        attr_accessor :inBioBank
        
        def initialize(params = {})
          
          @name = params.fetch(:name, 'Some Person')
          
        end
      
    end
  
    class BioBank
        attr_accessor :id
        attr_accessor :recruiting 
        
        def initialize(params = {})
          
          @name = params.fetch(:name, 'Some Person')
          
        end
      
    end
  
    class StudyDesign
        attr_accessor :id 
        attr_accessor :inclusionExclusionCriteria
        attr_accessor :recruitmentArea
        attr_accessor :recruitmentStartDate
        attr_accessor :recruitmentEndDate
        attr_accessor :numberOfCases
        attr_accessor :datasource
        attr_accessor :privacyPolicy
        attr_accessor :ethicalReviewCommittee
        attr_accessor :availableForFutureCollaboration
        attr_accessor :additionalProperties
        
        
        def initialize(params = {})
          
          @name = params.fetch(:name, 'Some Person')
          
        end
      
    end
  
    class BiologicalSample
        attr_accessor :id  
        attr_accessor :name
        attr_accessor :description
        attr_accessor :inCatalog
        attr_accessor :characteristic
        
        def initialize(params = {})
          
          @name = params.fetch(:name, 'Some Person')
          
        end
      
    end
  
    class Patient
        attr_accessor :id  
        attr_accessor :pseudonym
        attr_accessor :diagnosis
        attr_accessor :dateOfBirth
        attr_accessor :sex
        attr_accessor :status
        attr_accessor :dateOfDeath
        attr_accessor :firstContact
        attr_accessor :ageAtOnset
        attr_accessor :ageAtDiagnosis
        attr_accessor :diagnosisOfRareDisease
        attr_accessor :geneticDiagnosis
        attr_accessor :undiagnosedCase
        attr_accessor :additionalProperties
        
        
        def initialize(params = {})
          
          @name = params.fetch(:name, 'Some Person')
          
        end
      
    end
  
    class Code
        attr_accessor :id  
        attr_accessor :url
        attr_accessor :label
        attr_accessor :description
        
        def initialize(params = {})
          
          @name = params.fetch(:name, 'Some Person')
          
        end
      
    end
    
    class CodingSystem
        attr_accessor :id  
        attr_accessor :url
        attr_accessor :label
        attr_accessor :description
        
        def initialize(params = {})
          
          @name = params.fetch(:name, 'Some Person')
          
        end
    end
    
    class PropertyValue
        attr_accessor :id  
        attr_accessor :name
        attr_accessor :value
        attr_accessor :code
        
        def initialize(params = {})
          
          @name = params.fetch(:name, 'Some Person')
          
        end
    end
    
    class Organization
        attr_accessor :id  
        attr_accessor :name
        attr_accessor :facility
        attr_accessor :department
        attr_accessor :address
        
        def initialize(params = {})
          
          @name = params.fetch(:name, 'Some Person')
          
        end
    end
    
    class DateTime
        attr_accessor :id  
        attr_accessor :day
        attr_accessor :month
        attr_accessor :year
        attr_accessor :time
        
        def initialize(params = {})
          
          @name = params.fetch(:name, 'Some Person')
          
        end
    end
    
    class Location
        attr_accessor :street  
        attr_accessor :city
        attr_accessor :code
        attr_accessor :country
        
        def initialize(params = {})
          
          @name = params.fetch(:name, 'Some Person')
          
        end
    end
    
    class EUPID
        attr_accessor :id  
        attr_accessor :eupid
        
        def initialize(params = {})
          
          @name = params.fetch(:name, 'Some Person')
          
        end
    end
  

  end
end
