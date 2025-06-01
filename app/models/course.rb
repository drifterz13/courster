class Course < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "author_id"
  has_many :lessons, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :author, presence: true

  scope :with_lessons, ->(id) { includes(:lessons).find(id) }

  def max_lesson_order
    lessons.maximum(:order) || 0
  end

  def can_delete_by?(user)
    self.author.id == user.id
  end
end
