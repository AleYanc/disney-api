require 'rails_helper'

RSpec.describe Studio, :type => :model do
  before(:all) do
    @st1 = build(:studio)
    @rando = build(:rand_studio)
  end

  it 'is valid with valid attributes' do
    expect(@rando).to be_valid
  end

  context "invalid attributes" do
    it "is not valid when studio name is not present" do
      @st1.name = nil
      expect(@st1).to be_invalid
    end
  
    it "is not valid when foundation_date is not present" do
      @st1.foundation_date = nil
      expect(@st1).to be_invalid
    end
  end
end