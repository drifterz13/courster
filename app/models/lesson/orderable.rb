module Lesson::Orderable
  extend ActiveSupport::Concern

  included do
    validates :order, presence: true
    validates :order, uniqueness: { scope: :course_id, message: "should be unique within the course" }
    validates :order, numericality: { only_integer: true, greater_than: 0 }

    before_validation :set_lesson_order
  end

  def set_lesson_order
    max_order = self.course&.lessons.maximum(:order) || 0
    self.order = max_order + 1
  end
end
