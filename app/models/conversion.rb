# this is a simple model example
# check https://datamapper.org/getting-started.html
class Conversion
	include DataMapper::Resource

	property :id, Serial    # An auto-increment integer key
	property :from, String    # A varchar type string, for short strings
  property :to, String
  property :amount, Float
  property :result, Float
end


Conversion.auto_upgrade!
DataMapper.finalize
