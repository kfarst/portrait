require 'spec_helper'

describe Subscription do
  it 'should have a default transaction limit of 10' do
    Subscription.new.transaction_limit.should eq 10
  end

  context 'with a user' do
    it 'should be valid' do
      user = User.new
      Subscription.new(user: user).should be_valid
    end
  end

  context 'without a user' do
    it 'should not be valid' do
      Subscription.new.should_not be_valid
    end

    it 'should return the proper error' do
      sub = Subscription.new
      sub.valid?
      sub.errors.full_messages.should eq ["User can't be blank"]
    end
  end
end
