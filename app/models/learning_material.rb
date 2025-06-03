class LearningMaterial < ApplicationRecord
  include Attachable

  belongs_to :lesson

  validates :title, presence: true
end
