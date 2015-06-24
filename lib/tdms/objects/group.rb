require_relative 'base'

module TDMS
	module Objects
		class Group < Base
			attr_reader :channels

			def initialize(*args)
				super
				@channels = []
			end


			def to_hash
				super.merge({
						channel_count: @channels.length
					})
			end
		end
	end
end
