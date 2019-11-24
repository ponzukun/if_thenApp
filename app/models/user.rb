class User < ApplicationRecord
  before_save { email.downcase! }
  # before_save { self.email = email.downcase }
  # self.email = self.email.downcase 右式のselfは省略可能/左式は省略できない
  validates :name,  presence: true, length: { maximum: 50 }
  # validates(:name, presence: true) ()は省略可能
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end