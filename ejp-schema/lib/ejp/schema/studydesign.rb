

module EJP
  module Schema
  
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
          SioHelper::General.setNamespaces()
          
          @name = params.fetch(:name, 'Some Person')
          
        end
      
    end
  end
end

  
  