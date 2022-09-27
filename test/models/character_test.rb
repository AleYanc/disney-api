require "test_helper"

class CharacterTest < ActiveSupport::TestCase
  def setup
    @char = characters(:rayo)
  end

  test "valid character" do
    assert @char
  end

  test "invalid character without name" do
    @char.name = nil
    refute @char.valid?, 'saved without name'
    assert_not_nil @char.errors[:name], 'no validation error for name present'
  end

  test "#productions" do
    assert_equal 1, @char.productions.size
  end

  test "#studios" do
    assert_equal 1, @char.studios.size
  end
end
