require 'digest/md5'

class Password
  def self.encrypt(password)
    return nil if password.nil?
    encryption = Digest::MD5.digest(password)
    Base64.encode64(encryption).strip
  end
end
