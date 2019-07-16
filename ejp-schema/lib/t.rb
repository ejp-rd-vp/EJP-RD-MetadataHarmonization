$LOAD_PATH << '/home/markw/Documents/CODE/EJP-RD-MetadataHarmonization/ejp-schema/lib'
#$LOAD_PATH << '/home/osboxes/CODE/EJP-RD-MetadataHarmonization/ejp-schema/lib'

require 'sio_helper'
require 'ejp/schema'
require 'rdf/vocab'
require 'pry'

#fact = EJP::SchemaFactory.new({baseuri: 'http://thisisatest.uri/'})
#fact = EJP::SchemaFactory.new(baseuri: 'http://thisisatest.uri/')
factory = EJP::SchemaFactory.new()

code1 = factory.createCode({uri: "http://www.orpha.net/ORDO/Orphanet_586",
                       label: "Cystic Fibrosis",
                       description: "Cystic fibrosis (CF) is a genetic disorder characterized by the production of sweat with a high salt content and mucus secretions with an abnormal viscosity."})
code2 = factory.createCode({uri: "http://www.orpha.net/ORDO/Orphanet_98934",
                       label: "Huntington disease-like 2",
                       description: "Huntington disease-like 2 (HDL2) is a severe neurodegenerative disorder considered part of the neuroacanthocytosis syndromes (see this term) characterized by a triad of movement, psychiatric, and cognitive abnormalities."})
orphanet = factory.createOrganization({
              name: "Catalog of Registries",
              facility: "Orphanet",
              department: "Rare Disease Platform",
              street:  "96, rue Didot",
              city: "Paris",
              country: "FR",
              code: "75014"})
$stderr.puts "Org #{orphanet.name} created"

pcf = factory.createOrganization({
              name: "Polish cystic fibrosis registry group",
              facility: "Uniwersytet Medyczny im. Karola Marcinkowskiego w Poznaniu",
              street:  "Rokietnicka 8",
              city: "POZNAN",
              country: "PL",
              code: "60-806"})
$stderr.puts "Org #{pcf.name} created"

hun = factory.createOrganization({
              name: "UK Huntington disease registry",
              facility: "Cardiff School of Biosciences",
              street:  "Sir Martin Evans Building, Museum Avenue",
              city: "CARDIFF",
              country: "UK",
              code: "CF10 3AX"})
$stderr.puts "Org #{hun.name} created"

catalog = factory.createCatalog({
       alternateName: "OrphaCoR",
       title: "Orphanet: Registries & biobanks  ",
       publisher: orphanet,
       description: "The Orphanet Catalog of Registries and Biobanks",
       homepage:"https://www.orpha.net/consor/cgi-bin/ResearchTrials_RegistriesMaterials.php?lng=EN",
       license: "https://creativecommons.org/licenses/by/4.0/",
       })
$stderr.puts "catalog #{catalog.title} created"

cf_registry = factory.createPatientRegistry({
       title: "Polish cystic fibrosis patient registry",
       about: [code1],
       publisher: pcf,
       description: "this is a description",
       homepage:"http://homepage.org",
       license: "http://creativecommons.org/ccby",
       })
$stderr.puts "Reg #{cf_registry.title} created"

hun_registry = factory.createPatientRegistry({
       title: "UK Huntington disease registry",
       about: [code2],
       publisher: hun,
       description: "UK Huntington disease registry (collaborating with the EHDN/Euro HD Registry)",
       homepage:"http://hdresearch.ucl.ac.uk/completed-studies/registry/",
       license: "https://creativecommons.org/licenses/by/4.0/",
       })
$stderr.puts "Reg #{hun_registry.title} created"


#biosample = factory.createBiologicalSample({
#       identifier: "LoC223w67",
#       name: "Piece of lung LoC2288344",
#       title: "Piece of lung LoC2288344",
#       themes: [code1],
#       description: "This piece of lung was very strange, so we thought we should cut it out and see what happened",
#       landingPage:"http://pieces.of.bodies.org/biobank",
#})

catalog.addDataset(cf_registry)
$stderr.puts "dataset added"
catalog.addDataset(hun_registry)
$stderr.puts "dataset added"

catalog.build
puts catalog.graph.dump(:turtle)
#puts catalog.graph.dump(:jsonld)








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
