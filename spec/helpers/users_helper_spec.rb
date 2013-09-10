require 'spec_helper'

describe UsersHelper do
  describe 'transaction_limit' do
    context 'with an admin user' do
      let(:user) { subscriptions(:basic).user }

      it 'returns unlimited' do
        helper.transaction_limit(user).should eq 'Unlimited'
      end
    end

    context 'with a non-admin user' do
      let :user  do
        user = subscriptions(:basic).user
        user.update_attribute :admin, false
        user
      end

      it 'returns the transaction limit' do
        helper.transaction_limit(user).should eq 10
      end
    end
  end
end
