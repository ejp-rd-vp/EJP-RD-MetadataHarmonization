require "ejp/schema/version"
require 'sio_helper'

module Ejp
  module Schema
    class Error < StandardError; end

    class Catalog
        attr_accessor :id  
        attr_accessor :alternateName
        attr_accessor :about
        attr_accessor :name
        attr_accessor :description
        attr_accessor :homepage
        attr_accessor :sameAs
        attr_accessor :location
        
        def initialize(params = {})
          
          @name = params.fetch(:name, 'Some Person')
          
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
