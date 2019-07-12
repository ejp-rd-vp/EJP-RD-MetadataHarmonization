$LOAD_PATH << '/home/markw/Documents/CODE/EJP-RD-MetadataHarmonization/ejp-schema/lib'

require 'sio_helper'
require 'ejp/schema'

#fact = EJP::SchemaFactory.new({baseuri: 'http://thisisatest.uri/'})
#fact = EJP::SchemaFactory.new(baseuri: 'http://thisisatest.uri/')
fact = EJP::SchemaFactory.new()
c = fact.createCatalog({alternateName: "testcat",
       name: "Example Catalog",
       title: "Catalog Title",
       description: "this is a description",
       homepage:"http://homepage.org",
       license: "http://creativecommons.org/ccby",
       })
      


puts c.graph.dump(:ntriples)

