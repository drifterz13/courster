module LearningMaterial::Attachable
  extend ActiveSupport::Concern

  included do
    has_one_attached :media

    validates :media, presence: true
    validates :material_type, presence: true, inclusion: { in: %w[video document] }
    validate :allow_media_content, if: -> { media.attached? }
  end

  private

  def allow_media_content
    case material_type
    when "video"
      errors.add(:media, "video is not allowed") unless media.content_type.start_with?("video/")
    when "document"
      errors.add(:media, "document is not allowed") unless
        media.content_type.start_with?("application/pdf") ||
        media.content_type.start_with?("application/msword") ||
        media.content_type.start_with?("application/vnd.openxmlformats-officedocument.wordprocessingml.document")
    else
      errors.add(:material_type, "not allowed")
    end
  end
end
