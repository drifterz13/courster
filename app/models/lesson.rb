class Lesson < ApplicationRecord
  include Orderable

  belongs_to :course
  has_one :learning_material, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true

  accepts_nested_attributes_for :learning_material

  delegate :can_delete_by?, to: :course
end
