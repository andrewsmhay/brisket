class Cloudkeys
	class << self
		class ec2_keys
			ec2 = AWS::EC2.new(
		    :access_key_id => '', # => Enter your own EC2 Access Key ID
		    :secret_access_key => '') # => Enter your own EC2 Secret Access Key
		end
	end
end