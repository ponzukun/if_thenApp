class IfthenRule < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  scope :search_by_keyword, -> (keyword) {
    where("if_content LIKE :keyword", keyword: "%#{sanitize_sql_like(keyword)}%") if keyword.present?
  }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :if_content, presence: true, length: { maximum: 100 }
  validates :then_content, presence: true, length: { maximum: 100 }
  validate  :picture_size

  def self.search(search)
    if search
      where(['if_content LIKE ?', "%#{search}%"])
    else
      all
    end
  end

  def self.listen(listen)
    if listen.present?
      where(['if_content LIKE ?', "%#{sanitize_sql_like(listen)}%"])
    end
  end

  private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
