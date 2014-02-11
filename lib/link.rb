class Link
# This class corresponds to a table in the database
# We can use it to manipulate the data

	# this makes the instances of this class DataMapper resources
	include DataMapper::Resource

	# this block describes what resources our model will have
	property :id, Serial #Serial means that it will be auto-incremented for every record
	property :title, String
	property :url, String

end
