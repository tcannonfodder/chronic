require_relative 'helper'

class TestNewParsingMethods < TestCase
  # Wed Aug 16 14:00:00 UTC 2006
  TIME_2006_08_16_14_00_00 = Time.local(2006, 8, 16, 14, 0, 0, 0)

  def setup
    @time_2006_08_16_14_00_00 = TIME_2006_08_16_14_00_00
  end

  def test_swapped_anchor
    time = parse_now("5PM tomorrow")
    assert_equal Time.local(2006, 8, 17, 17), time

    time = parse_now("tomorrow 5PM")
    assert_equal Time.local(2006, 8, 17, 17), time
  end

  def test_natural_language_for_meeting
    time = parse_now("Meeting tomorrow @ 5PM")
    assert_equal Time.local(2006, 8, 17, 17), time

    time = parse_now("Meeting tomorrow at 5PM")
    assert_equal Time.local(2006, 8, 17, 17), time

    time = parse_now("Tomorrow's 5PM Meeting")
    assert_equal Time.local(2006, 8, 17, 17), time

    time = parse_now("Tomorrow’s 5PM Meeting")
    assert_equal Time.local(2006, 8, 17, 17), time

    time = parse_now("5PM Meeting tomorrow")
    assert_equal Time.local(2006, 8, 17, 17), time

    time = parse_now("Tomorrow's noon Meeting")
    assert_equal Time.local(2006, 8, 17, 12), time

    time = parse_now("5PM January 1st")
    assert_equal Time.local(2007, 1, 01, 17), time
  end

  private
  def parse_now(string, options={})
    Chronic.parse(string, {:now => TIME_2006_08_16_14_00_00 }.merge(options))
  end
  def pre_normalize(s)
    Chronic::Parser.new.pre_normalize s
  end
end