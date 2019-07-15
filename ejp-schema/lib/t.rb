$LOAD_PATH << '/home/markw/Documents/CODE/EJP-RD-MetadataHarmonization/ejp-schema/lib'
#$LOAD_PATH << '/home/osboxes/CODE/EJP-RD-MetadataHarmonization/ejp-schema/lib'

require 'sio_helper'
require 'ejp/schema'
require 'rdf/vocab'
require 'pry'

#fact = EJP::SchemaFactory.new({baseuri: 'http://thisisatest.uri/'})
#fact = EJP::SchemaFactory.new(baseuri: 'http://thisisatest.uri/')
factory = EJP::SchemaFactory.new()

code1 = factory.createCode({uri: "http://this.is.my.ontology/term1",
                       label: "Label of the Ontology Term1",
                       description: "Some definition for term1"})
code2 = factory.createCode({uri: "http://this.is.my.ontology/term2",
                       label: "Label of the Ontology Term2",
                       description: "Some definition for term2"})
organization = factory.createOrganization({
              name: "Center for Cool technologies",
              facility: "Facility of Rare Diseases",
              department: "Department of Pathology",
              street:  "56 Sparks Street",
              city: "Ottawa",
              country: "CA",
              code: "SO22345"})
catalog = factory.createPatientRegistry({
       alternateName: "testcat",
       name: "Example Catalog",
       title: "Catalog Title",
       about: [code1, code2],
       creator: organization,
       description: "this is a description",
       homepage:"http://homepage.org",
       license: "http://creativecommons.org/ccby",
       })


biosample = factory.createBiologicalSample({
       identifier: "LoC223w67",
       name: "Piece of lung LoC2288344",
       title: "Piece of lung LoC2288344",
       themes: [code1],
       description: "This piece of lung was very strange, so we thought we should cut it out and see what happened",
       landingPage:"http://pieces.of.bodies.org/biobank",
})

catalog.addDataset(biosample)

catalog.build
puts catalog.graph.dump(:turtle)








# reveals bug in RDF libraries
#a = RDF::Resource.new("http://a.a/aa#aa#aa")
#b = RDF::Resource.new("http://b.b")
#c = RDF::Resource.new("http://c.c")
#g = RDF::Graph.new
#s1 = RDF::Statement(a,b,c)
#g << s1
#puts g.size
#solutions = RDF::Query.execute(g) do
#  pattern [:blah, b,c]
#end
#puts solutions.first[:blah]
#puts g.dump(:ntriples)
#abort
