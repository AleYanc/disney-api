require "test_helper"

class StudioTest < ActiveSupport::TestCase
  def setup
    @studio = studios(:pixar)
  end

  test "valid genre" do
    assert @studio
  end

  test "invalid genre without name" do
    @studio.name = nil
    refute @studio.valid?, "saved without name"
    assert_not_nil @studio.errors[:name], "no validation error for name present"
  end

  test "invalid genre without foundation date" do
    @studio.foundation_date = nil
    refute @studio.valid?, "saved without name"
    assert_not_nil @studio.errors[:foundation_date], "no validation error for name present"
  end

  test "#productions" do
    assert_equal 2, @studio.productions.size
  end

  test "scope by name" do
    assert_includes Studio.by_name('Pixar'), studios(:pixar)
  end
end
