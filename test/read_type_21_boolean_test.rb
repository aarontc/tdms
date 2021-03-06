require_relative 'test_helper'

class ReadType21BooleanTest < Minitest::Test
	def test_reads_one_boolean_channel_in_one_segment
		filename = fixture_filename('type_21_boolean_one_segment')
		doc = RubyTDMS::File.parse(filename)

		assert_equal 1, doc.segments.size
		assert_equal 1, doc.channels.size
		assert_equal RubyTDMS::DataTypes::Boolean::ID, doc.channels[0].data_type_id

		chan = doc.channels.find { |ch| ch.path == '/boolean_group/boolean_channel' }
		assert_equal 2, chan.values.size

		expected = [true, false]
		assert_equal expected, chan.values.to_a
	end


	def test_reads_two_boolean_channels_in_one_segment
		filename = fixture_filename('type_21_boolean_two_channels_one_segment')
		doc = RubyTDMS::File.parse(filename)

		assert_equal 1, doc.segments.size
		assert_equal 2, doc.channels.size
		assert_equal RubyTDMS::DataTypes::Boolean::ID, doc.channels[0].data_type_id
		assert_equal RubyTDMS::DataTypes::Boolean::ID, doc.channels[1].data_type_id

		chan = doc.channels.find { |ch| ch.path == '/boolean_group/boolean_channel_a' }
		assert_equal 2, chan.values.size
		expected = [true, false]
		assert_equal expected, chan.values.to_a

		chan = doc.channels.find { |ch| ch.path == '/boolean_group/boolean_channel_b' }
		assert_equal 2, chan.values.size
		expected = [false, true]
		assert_equal expected, chan.values.to_a
	end


	def test_reads_one_boolean_channel_across_three_segments
		filename = fixture_filename('type_21_boolean_three_segments')
		doc = RubyTDMS::File.parse(filename)

		assert_equal 3, doc.segments.size
		assert_equal 1, doc.channels.size
		assert_equal 1, doc.segments[1].objects.size
		assert_equal 1, doc.segments[2].objects.size
		assert_equal RubyTDMS::DataTypes::Boolean::ID, doc.channels[0].data_type_id
		assert_equal RubyTDMS::DataTypes::Boolean::ID, doc.segments[1].objects[0].data_type_id
		assert_equal RubyTDMS::DataTypes::Boolean::ID, doc.segments[2].objects[0].data_type_id

		chan = doc.channels.find { |ch| ch.path == '/boolean_group/boolean_channel' }
		assert_equal 6, chan.values.size
		expected = [true, false, true, false, true, false]
		assert_equal expected, chan.values.to_a
	end
end
