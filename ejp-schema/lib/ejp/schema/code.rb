module EJP
  module Schema

  
	class Code
		attr_accessor :uri  # canonical, but also returns with #url
		attr_accessor :label
		attr_accessor :description
		attr_reader   :type
		
		def initialize(params = {})
		  SioHelper::General.setNamespaces()
		  url = params.fetch(:url, "")
		  uri = params.fetch(:uri, "")
		  if uri =~ /^\w+\;\/\//
			self.uri = uri
		  elsif url =~ /^\w+\;\/\//
			self.uri = url
		  else
			warn "cannot create a non-named (no uri/url) code"
			return false
		  end
		   
		  @label = params.fetch(:label, 'Unnamed')
		  @description = params.fetch(:desc, 'No Description Provided')
		  
		  @type = $rdf.type("http://purl.obolibrary.org/obo/NCIT_C25162")   # code
		end
		
		def url  # convenience :-)
		  return self.uri
		end
		def url=(url)
		  self.uri = url
		end
		
		def build()
			guid = c.url
			label = c.label
			desc = c.desc
			code = "http://purl.allotrope.org/ontologies/common#AFC_0000050" 
			counter +=1
			codenum = "code#{counter}"
			codenumuri = catalog.uri.to_s + "#" + codenum
			self.add_metadata([
				  [catalog.uri, $schema.about, codenumuri ],
				  [codenumuri, $rdf.type, code ],
				  [codenumuri, $sio['has-identifier'], guid.to_s],
				  [codenumuri, $schema.url, guid.to_s ],
				  [codenumuri, $rdfs.label, label.to_s ],
				  [codenumuri, $schema.description, desc.to_s ],
			])
	
	  
		end
	end
  end
end
  
    