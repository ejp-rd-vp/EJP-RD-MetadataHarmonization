


module EJP
  module Schema

  
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
          SioHelper::General.setNamespaces()

          
          @name = params.fetch(:name, 'Some Person')
          
        end
      
    end
  end
end

  