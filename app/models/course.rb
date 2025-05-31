class Course < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :lessons, dependent: :nullify

  before_validation :set_lesson_order, if: -> { lessons.any? }

  validates_presence_of :title, :description, :author

  accepts_nested_attributes_for :lessons, reject_if: :all_blank, allow_destroy: true

  def set_lesson_order
    lessons.reject(&:marked_for_destruction?).each_with_index do |lesson, index|
      lesson.order = index + 1
    end
  end
end
