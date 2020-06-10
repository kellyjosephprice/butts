require "test_helper"

class ButtsTest < Minitest::Test
  def setup
    @butts = Butts::Seats.new
  end

  def test_that_it_has_a_version_number
    refute_nil ::Butts::VERSION
  end

  def test_simple_rule
    @butts.add_rule(@butts.students[0]) do |b|
      b.students[0].length.times.map { |y| [0, y] }
    end

    @butts.assign

    assert(@butts.seats.first, @butts.students[0])
  end

  def test_two_rules
    @butts
      .add_rule(@butts.students[0]) do |b|
        b.students[0].length.times.map { |y| [0, y] }
      end
      .add_rule(@butts.students[1]) do |b|
        b.students[0].length.times.map { |y| [0, y] }
      end

    @butts.assign

    assert(@butts.seats.first, @butts.students[0])
    assert(@butts.seats.first, @butts.students[1])
  end

  def test_unsolveable
    10.times do
      @butts
        .add_rule(@butts.students[0]) do |butts|
          butts.students[0].length.times.map { |y| [0, y] }
        end
    end

    exception = assert_raises RuntimeError do
      @butts.assign
      puts @butts
    end
    assert_equal("Too many constraints!", exception.message)
  end
end
