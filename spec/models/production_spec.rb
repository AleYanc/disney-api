require 'rails_helper'

RSpec.describe Production, :type => :model do
  before(:all) do
    @rando = build(:rand_production)
  end

  it "is valid with valid attributes" do
    expect(@rando).to be_valid
  end

  it "is invalid when title is not present" do
    @rando.title = nil
    expect(@rando).to be_invalid
  end

  it "is invalid when released date is not present" do
    @rando.released_date = nil
    expect(@rando).to be_invalid
  end

  it "is invalid when score is not present" do
    @rando.score = nil
    expect(@rando).to be_invalid
  end
end