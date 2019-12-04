class IfthenRule < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :if, presence: true, length: { maximum: 100 }
  validates :then, presence: true, length: { maximum: 100 }
end
