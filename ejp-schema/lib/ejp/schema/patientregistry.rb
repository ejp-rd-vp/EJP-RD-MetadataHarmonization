
module EJP
  module Schema
    class PatientRegistry < EJP::Schema::GenericRegistry
        attr_accessor :id
        attr_accessor :studydesign
        attr_accessor :inBiobank
        attr_accessor :hasBiobank
        
        def initialize(params = {})

          SioHelper::General.setNamespaces()
          super
          
          @name = params.fetch(:studydesign, '')
          @name = params.fetch(:inBioBank, nil)
          @name = params.fetch(:hasBioBank, '')
          
        end
      
    end
  end
end

