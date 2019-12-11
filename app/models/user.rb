class User < ApplicationRecord
  has_many :ifthen_rules, dependent: :destroy
  attr_accessor :remember_token
  before_save { email.downcase! }
  # before_save { self.email = email.downcase }
  # self.email = self.email.downcase 右式のselfは省略可能/左式は省略できない
  validates :name,  presence: true, length: { maximum: 50 }
  # validates(:name, presence: true) ()は省略可能
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  # has_secure_passwordは、オブジェクト生成時に存在性を検証
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにユーザーをDBに記憶
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    # remember_token（User.new_tokenで生成された値）
    # remember_digest（remember_tokenをUser.digestでハッシュ化した値）
  end

  # 渡されたトークンがダイジェストと一致したらtrue
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄
  def forget
    update_attribute(:remember_digest, nil)
  end

  # 試作feedの定義（今の所必要ないが一応残す）
  # def feed
  #   IfthenRule.where("user_id = ?", id)
  #   ↑は、ifthen_rulesと本質的に同等
  # end
end
