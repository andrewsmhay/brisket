#!/usr/bin/env ruby
require 'smarter_csv'
require 'mongoid'

Mongoid.load!("./mongoid.yml", :development)

class MyModel
  include Mongoid::Document
  include Mongoid::Timestamps # gives you two fields - created_at, updated_at
	  field :Date, type: Date
	  field :Scanner, type: String
	  field :CSP, type: String
	  field :IP, type: String
	  field :Port, type: Integer
	  field :Latt, type: Float
	  field :Long, type: Float
	  field :Country, type: String
	  field :Continent, type: String
	  field :Region, type: String
	  field :City, type: String
	  field :PageTitle, type: String
	  field :App, type: String
	  field :AppStack, type: String
end

commands = []
ARGV.each {|arg| commands << arg}

# using chunks:
filename = ARGV[0]

if ARGV[1] == "banner"
	n = SmarterCSV.process(filename, {:chunk_size => 100, :key_mapping => {
			:Date => :Date, 
			:Scanner => :Scanner,
			:CSP => :CSP,
			:IP => :IP,
			:Port => :Port,
			:App => :App,
			:AppStack => :AppStack
			}}) do |chunk|
	      # we're passing a block in, to process each resulting hash / row (block takes array of hashes)
	      # when chunking is enabled, there are up to :chunk_size hashes in each chunk
				MyModel.collection.insert( chunk )   # insert up to 100 records at a time
			end

elsif ARGV[1] == "title"
	n = SmarterCSV.process(filename, {:chunk_size => 100, :key_mapping => {
			:Date => :Date, 
			:Scanner => :Scanner,
			:CSP => :CSP,
			:IP => :IP,
			:Port => :Port,
			:PageTitle => :PageTitle
			}}) do |chunk|
	      # we're passing a block in, to process each resulting hash / row (block takes array of hashes)
	      # when chunking is enabled, there are up to :chunk_size hashes in each chunk
				MyModel.collection.insert( chunk )   # insert up to 100 records at a time
			end

else	
	n = SmarterCSV.process(filename, {:chunk_size => 100, :key_mapping => {
			:Date => :Date, 
			:Scanner => :Scanner,
			:CSP => :CSP,
			:IP => :IP,
			:Port => :Port,
			:Latt => :Latt,
			:Long => :Long,
			:Country => :Country,
			:Continent => :Continent,
			:Region => :Region,
			:City => :City
			}}) do |chunk|
				MyModel.collection.insert( chunk )
  			end
end