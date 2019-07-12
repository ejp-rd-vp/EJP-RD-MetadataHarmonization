
module EJP
  module Schema

    class CodingSystem
        attr_accessor :id  
        attr_accessor :url
        attr_accessor :label
        attr_accessor :description
        
        def initialize(params = {})
          SioHelper::General.setNamespaces()
          
          @id = params.fetch(:id, "")
          @url = params.fetch(:url, "")
          @label = params.fetch(:label, 'Unnamed')
          @description = params.fetch(:desc, 'No Description Provided')
          
        end
    end
  end
end

