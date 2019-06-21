require "ejp/schema/version"
require 'sio_helper'

module EJP
    class LDPServer
      attr_accessor :server
      
      def initialize(params = {})
        @server = params.fetch(:server, "http://fake.server.org/" )
        @base = params.fetch(:server, "http://fake.server.org/" )
        @uri = params.fetch(:server, "http://fake.server.org/" )
      end
      
      def setNamespaces()
        @rdf =  RDF::Vocabulary.new("http://www.w3.org/1999/02/22-rdf-syntax-ns#")
        @rdfs = RDF::Vocabulary.new("http://www.w3.org/2000/01/rdf-schema#")
        @ldp = RDF::Vocabulary.new("http://www.w3.org/ns/ldp#")
        @sio = RDF::Vocabulary.new("http://semanticscience.org/resource/")
        @uo =  RDF::Vocabulary.new("http://purl.obolibrary.org/obo/uo.owl#")
        @efo = RDF::Vocabulary.new("http://www.ebi.ac.uk/efo/efo.owl#")
        @taxon = RDF::Vocabulary.new("http://purl.obolibrary.org/obo/NCBITaxon_")
        @rel = RDF::Vocabulary.new("http://purl.obolibrary.org/obo/RO_")
        @obi = RDF::Vocabulary.new("http://purl.obolibrary.org/obo/OBI_")
        @ero = RDF::Vocabulary.new("http://purl.obolibrary.org/obo/ERO_")
        @rdc = RDF::Vocabulary.new("http://rdf.biosemantics.org/ontologies/rd-connect/rdc-meta/")
        @ncit = RDF::Vocabulary.new("http://purl.obolibrary.org/obo/NCIT_")
        @ordo =  RDF::Vocabulary.new("http://www.orpha.net/ORDO/")
        @dbsnp = RDF::Vocabulary.new("https://www.ncbi.nlm.nih.gov/snp/")
        @dcat = RDF::Vocabulary.new("http://www.w3.org/ns/dcat#")
        @skos = RDF::Vocabulary.new("http://www.w3.org/2004/02/skos/core#")
        @dct = RDF::Vocabulary.new("http://purl.org/dc/terms/")
        @schema = RDF::Vocabulary.new("http://schema.org/")
        @foaf = RDF::Vocabulary.new("http://xmlns.com/foaf/0.1/")
      end
      

    end
end