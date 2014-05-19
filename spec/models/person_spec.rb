require 'spec_helper'

describe Person do

  before :each do
    @person = Person.new first_name: 'John', last_name: 'Doe'
  end

  it "should require a customer to have an age", rox: { key: '6189a846be4f' } do
    @person.age = nil
    expect(@person.valid?).to be_false
  end

  it "should allow an adult to be registered", rox: { key: '5676a2a9d376' } do
    [ 18, 20, 50 ].each do |age|
      @person.age = age
      expect(@person.valid?).to be_true
    end
  end

  it "should not allow underage customers", rox: { key: '3902c0ea2719' } do
    [ 0, 2, 17 ].each do |age|
      @person.age = age
      expect(@person.valid?).to be_false
    end
  end
end
