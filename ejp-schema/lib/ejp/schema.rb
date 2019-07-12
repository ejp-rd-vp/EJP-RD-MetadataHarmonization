require "ejp/schema/version"
require 'sio_helper'
require 'rdf'
require 'rdf/turtle'
require 'uuidtools'
require 'ejp/schemafactory'

$ejp =  RDF::Vocabulary.new("http://www.ejprarediseases.org/resources/ontology#")  # set global variable for our ontology
$example =  RDF::Vocabulary.new("http://www.ejprarediseases.org/resources/example#")  # set global variable for our ontology

module EJP
  module Schema

  end
end
