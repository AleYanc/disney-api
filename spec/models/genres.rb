require 'rails_helper'

RSpec.describe Genre, :type => :model do
  before(:all) do
    @genre = build(:random_genre)
  end

  it 'is valid with valid attributes' do
    expect(@genre).to be_valid
  end

  context "invalid attributes" do
    it "is not valid when character name is not present" do
      @genre.name = nil
      expect(@genre).to be_invalid
    end
  end
end