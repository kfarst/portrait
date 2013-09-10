module UsersHelper
  def transaction_limit(user)
    user.admin? ? 'Unlimited' : user.subscription.transaction_limit
  end
end
