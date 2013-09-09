require 'spec_helper'

describe Subscription do
  it 'should have a default transaction limit of 10' do
    Subscription.new.transaction_limit.should eq 10
  end
end
