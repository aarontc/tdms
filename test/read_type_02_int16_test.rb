require_relative 'test_helper'

class ReadType02Int16Test < Minitest::Test
	def test_reads_one_int16_channel_in_one_segment
		filename = fixture_filename('type_02_int16_one_segment')
		doc = RubyTDMS::File.parse(filename)

		assert_equal 1, doc.segments.size
		assert_equal 1, doc.channels.size
		assert_equal RubyTDMS::DataTypes::Int16::ID, doc.channels[0].data_type_id

		chan = doc.channels.find { |ch| ch.path == '/int16_group/int16_channel' }
		assert_equal 5, chan.values.size

		expected = [-32_768, -16_384, 0, 16_383, 32_767]
		assert_equal expected, chan.values.to_a
	end


	def test_reads_two_int16_channels_in_one_segment
		filename = fixture_filename('type_02_int16_two_channels_one_segment')
		doc = RubyTDMS::File.parse(filename)

		assert_equal 1, doc.segments.size
		assert_equal 2, doc.channels.size
		assert_equal RubyTDMS::DataTypes::Int16::ID, doc.channels[0].data_type_id
		assert_equal RubyTDMS::DataTypes::Int16::ID, doc.channels[1].data_type_id

		chan = doc.channels.find { |ch| ch.path == '/int16_group/int16_channel_a' }
		assert_equal 5, chan.values.size
		expected = [-32_768, -16_384, 0, 16_383, 32_767]
		assert_equal expected, chan.values.to_a

		chan = doc.channels.find { |ch| ch.path == '/int16_group/int16_channel_b' }
		assert_equal 5, chan.values.size
		expected = [32_767, 16_383, 0, -16_384, -32_768]
		assert_equal expected, chan.values.to_a
	end


	def test_reads_one_int16_channel_across_three_segments
		filename = fixture_filename('type_02_int16_three_segments')
		doc = RubyTDMS::File.parse(filename)

		assert_equal 3, doc.segments.size
		assert_equal 1, doc.channels.size
		assert_equal 1, doc.segments[1].objects.size
		assert_equal 1, doc.segments[2].objects.size
		assert_equal RubyTDMS::DataTypes::Int16::ID, doc.channels[0].data_type_id
		assert_equal RubyTDMS::DataTypes::Int16::ID, doc.segments[1].objects[0].data_type_id
		assert_equal RubyTDMS::DataTypes::Int16::ID, doc.segments[2].objects[0].data_type_id

		chan = doc.channels.find { |ch| ch.path == '/int16_group/int16_channel' }
		assert_equal 15, chan.values.size
		expected = [-32_768, -16_384, 0, 16_383, 32_767,
			-32_768, -16_384, 0, 16_383, 32_767,
			-32_768, -16_384, 0, 16_383, 32_767]
		assert_equal expected, chan.values.to_a
	end
end
