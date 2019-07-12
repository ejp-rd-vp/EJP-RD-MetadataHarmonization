

module EJP
  module Schema
    
    class Organization

        attr_accessor :name
        attr_accessor :facility
        attr_accessor :department
        attr_accessor :address
        
        def initialize(params = {})
          SioHelper::General.setNamespaces()
          
          @name = params.fetch(:name, 'Organization Name Not Provided')
          @facility = params.fetch(:facility, "")
          @department = params.fetch(:department, "")
          @address = params.fetch(:address, "")
          if !address.nil? and !@address.is_a? EJP::Schema::Location
            warn "Deleting Organization because the provided address is not an EJP::Schema::Location"
            @address = nil
          end
        end
    end
  end
end

