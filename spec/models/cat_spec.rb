require 'rails_helper'
# use rspec
# require 'rspec'
# # tell rspec to test 'book' and where the file exists
# require_relative 'cat'

RSpec.describe Cat, type: :model do
  it 'has to be real' do
    # using curly brackets because we expect behavior
    # raise_error, be_a, eq are all matchers
    expect{Cat.new}.to_not raise_error
  end

  it 'has a name' do
    my_cat = Cat.new
    my_cat.name = 'Snookums'
    expect(my_cat.name).to be_a String
    expect(my_cat.name).to eq 'Snookums'
  end

end
