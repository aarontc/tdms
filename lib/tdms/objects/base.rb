module TDMS
	module Objects
		# TDMS object base.
		# All objects hold a collection of Segment references since objects can be striped across segments.
		class Base
			attr_reader :path, :properties, :segment, :stream

			def initialize(path, document, segment)
				@path = path
				@document = document
				@segment = segment
				@stream = document.stream

				@properties = []
			end


			def parse_stream(stream)
				@properties_length = stream.read_u32
				@properties_length.times do
					@properties << stream.read_property(@segment.big_endian?)
				end
			end
		end
	end
end