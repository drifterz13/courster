class Lesson < ApplicationRecord
  belongs_to :course
  has_one :learning_material, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :order, presence: true
  validates :order, uniqueness: { scope: :course_id, message: "should be unique within the course" }
  validates :order, numericality: { only_integer: true, greater_than: 0 }

  before_validation :set_lesson_order

  accepts_nested_attributes_for :learning_material

  def set_lesson_order
    max_order = self.course&.lessons.maximum(:order) || 0
    self.order = max_order + 1
  end

  def can_delete_by?(user)
    self.course.can_delete_by?(user)
  end
end
