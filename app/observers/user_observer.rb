class UserObserver < ActiveRecord::Observer
  def after_initialize(user)
    user.build_subscription
  end
end
