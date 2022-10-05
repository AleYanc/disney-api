require 'rails_helper'

RSpec.describe Character, :type => :model do
  before(:all) do
    @rando = build(:random_character)
  end

  it 'is valid with valid attributes' do
    expect(@rando).to be_valid
  end

  context "invalid attributes" do
    it "is not valid when character name is not present" do
      @rando.name = nil
      expect(@rando).to be_invalid
    end
  
    it "is not valid when character age is not present" do
      @rando.age = nil
      expect(@rando).to be_invalid
    end

    it "is not valid when character weight is not present" do
      @rando.weight = nil
      expect(@rando).to be_invalid
    end

    it "is not valid when character history is not present" do
      @rando.history = nil
      expect(@rando).to be_invalid
    end
  end
end