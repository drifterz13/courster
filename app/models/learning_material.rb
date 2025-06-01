class LearningMaterial < ApplicationRecord
  has_one_attached :media

  belongs_to :lesson

  validates :title, presence: { message: "Title can't be blank" }
  validates :media, presence: { message: "Media can't be blank" }
  validates :allowed_media_types, presence: { message: "Media type is not allowed" }

  def allowed_media_types
    return false if media.blank?

    case material_type
    when "video"
      media.content_type.start_with?("video/")
    when "document"
      media.content_type.start_with?("application/pdf") || media.content_type.start_with?("application/msword") || media.content_type.start_with?("application/vnd.openxmlformats-officedocument.wordprocessingml.document")
    else
      false
    end
  end
end
