class UserObserver < ActiveRecord::Observer
  def after_initialize(user)
    user.build_subscription
  end

  def before_save(user)
    encrypted_password = Password.encrypt(user.password)
    user.password = encrypted_password
  end
end
