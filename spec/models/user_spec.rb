require 'rails_helper'

RSpec.describe User, :type => :model do
  before(:all) do
    @rando = build(:user)
  end

  it "is valid with valid attributes" do
    expect(@rando).to be_valid
  end

  it "is invalid when email is not present" do
    @rando.email = nil
    expect(@rando).to be_invalid
  end

  it "is invalid when password is not present" do
    @rando.password = nil
    expect(@rando).to be_invalid
  end
end