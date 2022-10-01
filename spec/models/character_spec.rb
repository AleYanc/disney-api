require 'rails_helper'

RSpec.describe Character, :type => :model do
  before(:all) do
    @char1 = create(:random_character)
  end

  it 'is valid with valid attributes' do
    expect(@char1).to be_valid
  end
end