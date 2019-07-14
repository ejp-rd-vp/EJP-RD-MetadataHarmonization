


module EJP
  module Schema

  
    class Patient < EJP::Schema::Sample
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
          super
          
          SioHelper::General.setNamespaces()

          @name = params.fetch(:name, 'Unidentified Patient')
          @pseudonym = params.fetch(:pseudonym, "")
          @diagnosis = params.fetch(:diagnosis, 'Undiagnosed')
          @dateOfBirth = params.fetch(:dateOfBirth, '01-01-0001')
          @sex = params.fetch(:sex, 'Unknown')
          @status = params.fetch(:status, 'Unknown')
          @dateOfDeath = params.fetch(:dateOfDeath, '01-01-0001')
          @firstContact = params.fetch(:firstContact, '01-01-0001')
          @ageAtOnset = params.fetch(:ageAtOnset, nil)
          @additionalProperties = params.fetch(:additionalProperties, [])
          
          @additionalProperties = [@additionalProperties] unless @additionalProperties.is_a?(Array)
          @additionalProperties.each do |p|
            if !p.is_a?(EJP::Schema::PropertyValue)
              @additionalProperties.delete(p)
              warn "removing #{p} because it is not an EJP Schema PropertyValue object"
            end
          end

          self.build
          
        end
        
        
        def build
            parentgraph = super.build
            
            SioHelper::General.setNamespaces()

            dataset = self
            f = self.factory
            g = self.graph
            
            g << parentgraph

            
            f.add_triples(g, [
                [dataset.uri, $schema.name, dataset.name],
                [dataset.uri, $ejp.pseudonym, dataset.pseudonym],
                [dataset.uri, $ejp.diagnosis, dataset.diagnosis],
                [dataset.uri, $ejp.dateOfBirth, dataset.dateOfBirth],
                [dataset.uri, $ejp.sex, dataset.sex],
                [dataset.uri, $ejp.status, dataset.status],
                [dataset.uri, $ejp.dateOfDeath, dataset.dateOfDeath],
                [dataset.uri, $ejp.firstContact, dataset.firstContact],
                [dataset.uri, $ejp.ageAtOnset, dataset.ageAtOnset],
            ])
            

            
            themes = Array.new
            dataset.themes.each do |t|
              themes.concat([dataset.uri, dcat.theme, t.uri]) 
            end
            f.add_triples(g, [themes.flatten!])
                    
            return g
        end

      
    end
  end
end

  