require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User, 'authentication' do
  it 'should authenticate a valid user' do
    User.authenticate('jordan', 'password').should == users(:jordan)
  end

  it 'should not authenticate valid user with wrong password' do
    User.authenticate('jordan', 'wrong').should be_nil
  end

  it 'should not authenticate valid user with nil password' do
    User.authenticate('jordan', nil).should be_nil
  end

  it 'should not authenticate with invalid user name' do
    User.authenticate('invalid', 'anything').should be_nil
  end

  it 'should not authenticate with nil user name' do
    User.authenticate(nil, nil).should be_nil
  end
end

describe User, 'validations' do
  it 'should have a name' do
    User.new.should have(1).error_on(:name)
  end

  it 'should have a name with valid characters' do
    User.new(name: 'INVALID').should have(1).error_on(:name)
  end

  it 'should have a password' do
    User.new.should have(1).error_on(:password)
  end

  it 'should have a unique name' do
    User.new(name: users('jordan').name).should have(1).error_on(:name)
  end
end

describe 'after initializaiton' do
  it 'should have a subscription' do
    User.new.subscription.should_not be_nil
  end
end

describe 'before saving' do
  it 'should encrypt the passwod' do
    user = User.new(name: 'test', password: 'test')
    user.save
    user.password.should_not eq 'test'
  end
end
