require "test_helper"

class GenreTest < ActiveSupport::TestCase
  def setup
    @genre = genres(:aventura)
  end

  test "valid genre" do
    assert @genre
  end

  test "invalid genre without name" do
    @genre.name = nil
    refute @genre.valid?, 'saved without name'
    assert_not_nil @genre.errors[:name], 'no validation error for name present'
  end

  test "#productions" do
    assert_equal 1, @genre.productions.size
  end
end
