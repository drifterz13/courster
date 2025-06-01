class LearningMaterial < ApplicationRecord
  belongs_to :lesson

  validates :title, presence: { message: "Title can't be blank" }
  validates :file_url, url: true, presence: { message: "File URL can't be blank" }
end
