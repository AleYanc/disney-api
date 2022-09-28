require "test_helper"

class ProductionTest < ActiveSupport::TestCase
  def setup
    @prod = productions(:cars)
  end

  test "valid production" do
    assert @prod
  end

  test "invalid production without title" do
    @prod.title = nil
    refute @prod.valid?, 'saved without title'
    assert_not_nil @prod.errors[:title], 'no validation error for title present'
  end

  test "invalid production without released date" do
    @prod.released_date = nil
    refute @prod.valid?, 'saved without title'
    assert_not_nil @prod.errors[:released_date], 'no validation error for released_date present'
  end

  test "invalid production score" do
    p = Production.new(title:'Cars', released_date: '1870-09-09', score: 56)
    assert_not p.valid?
  end

  test "#genres" do
    assert_equal 2, @prod.genres.size
  end

  test "#characters" do
    assert_equal 2, @prod.characters.size
  end

  test "#studios" do
    assert_equal 1, @prod.studios.size
  end

  test "title scope" do
    assert_includes Production.title('Cars'), productions(:cars)
    refute_includes Production.title('Cars 2'), productions(:cars)
  end

  test "genre scope" do
    animacion = genres(:animacion)
    
    assert_includes Production.genre((animacion.id).to_s), productions(:toy_story)
    assert_includes Production.genre((animacion.id).to_s), productions(:cars)
    assert_equal 2, Production.genre((animacion.id).to_s).size
  end
end
