require 'rails_helper'

RSpec.describe Character, :type => :model do
  before(:all) do
    @char1 = build(:character)
    @rando = build(:random_character)
  end

  it 'is valid with valid attributes' do
    expect(@rando).to be_valid
  end

  context "invalid attributes" do
    it "is not valid when character name is not present" do
      @char1.name = nil
      expect(@char1).to be_invalid
    end
  
    it "is not valid when character age is not present" do
      @char1.age = nil
      expect(@char1).to be_invalid
    end

    it "is not valid when character weight is not present" do
      @char1.weight = nil
      expect(@char1).to be_invalid
    end

    it "is not valid when character history is not present" do
      @char1.history = nil
      expect(@char1).to be_invalid
    end
  end
end