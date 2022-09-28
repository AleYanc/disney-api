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

  test "scope by name" do
    assert_includes Character.by_name('Rayo'), characters(:rayo)
    assert_includes Character.by_name('Ra'), characters(:rayo)
    assert_equal 2, Character.by_name('a').size # mAte y rAyo, para asegurarnos que el 'like' funciona como se debe
  end

  test "scope by age" do
    assert_includes Character.by_age(12, 30), characters(:rayo)
    refute_includes Character.by_age(31, 40), characters(:rayo)
    assert_equal 2, Character.by_age(20, 40).size #rayo 30 y mate 35
  end

  test "scope by weight" do
    assert_includes Character.by_weight(300, 700), characters(:rayo)
    refute_includes Character.by_weight(700, 1000), characters(:rayo)
    assert_equal 2, Character.by_weight(500, 1220).size #rayo 30 y mate 35
  end

  test "scope by production" do
    cars = productions(:cars)
    assert_includes Character.by_production((cars.id).to_s), characters(:rayo), characters(:mate)
  end
end
