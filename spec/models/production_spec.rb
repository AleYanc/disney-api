require 'rails_helper'

RSpec.describe Production, :type => :model do
  before(:all) do
    @prod1 = build(:production)
    @rando = build(:rand_production)
  end

  it "is valid with valid attributes" do
    expect(@rando).to be_valid
  end
end