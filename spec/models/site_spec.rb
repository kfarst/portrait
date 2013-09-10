require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Site, 'relationships' do
  it 'should belong to a user' do
    sites(:google).user.should == users(:jordan)
  end
end

describe Site do
  it 'should have an image url' do
    sites(:google).image_url.should == '/sites/1/original/google.png'
  end
end

describe Site, 'validations' do
  let(:user) { subscriptions(:basic).user }

  it 'should have an url' do
    Site.new(user: user).should have(1).error_on(:url)
  end

  it 'should have a valid url' do
    Site.new(user: user, url: 'invalid').should have(1).error_on(:url)
  end

  it 'should belong to a user' do
    Site.new.should have(1).error_on(:user_id)
  end

  context 'with the number of created sites exceeding the subscription transaction limit' do
    before(:each) { user.subscription.update_attribute :transaction_limit, 0 }

    context 'and the user is an admin' do
      it 'should create the site' do
        Site.new(user: user, url: "http://www.google.com").should be_valid
      end

      it 'should not have any error' do
        site = Site.new(user: user, url: "http://www.google.com")
        site.errors.full_messages.should have(0).errors
      end
    end

    context 'and the user is not an admin' do
      before(:each) { user.update_attribute :admin, false }

      it 'should not create the site' do
        Site.new(user: user, url: "http://www.google.com").should_not be_valid
      end

      it 'should return an error' do
        site = Site.new(user: user, url: "http://www.google.com")
        site.save.should be_false
        site.errors.full_messages.should eq ["You have exceeded your transaction limit"]
      end
    end

  end
end
