require "test_helper"

class LearningMaterialTest < ActiveSupport::TestCase
  test "should not save learning material without media" do
    lesson = lessons(:no_media)
    learning_material = LearningMaterial.new(title: "Test Material", material_type: "video", lesson:)
    refute learning_material.save
    assert_includes learning_material.errors[:media], "can't be blank"
  end

  test "should not save learning material with invalid media type" do
    lesson = lessons(:no_media)
    learning_material = LearningMaterial.new(title: "Test Material", material_type: "unknown", lesson:)
    learning_material.media.attach(
      io: File.open(Rails.root.join("test", "fixtures", "files", "sample_video.mp4")),
      filename: "sample_video.mp4",
      content_type: "video/mp4"
    )
    refute learning_material.save
    assert_includes learning_material.errors[:material_type], "not allowed"
  end

  test "should save learning material with video media" do
    lesson = lessons(:no_media)
    learning_material = LearningMaterial.new(title: "Test Material", material_type: "video", lesson:)
    learning_material.media.attach(
      io: File.open(Rails.root.join("test", "fixtures", "files", "sample_video.mp4")),
      filename: "sample_video.mp4",
      content_type: "video/mp4"
    )
    assert learning_material.save
  end

  test "should save learning material with pdf media" do
    lesson = lessons(:no_media)
    learning_material = LearningMaterial.new(title: "Test Material", material_type: "document", lesson:)
    learning_material.media.attach(
      io: File.open(Rails.root.join("test", "fixtures", "files", "sample_pdf.pdf")),
      filename: "sample_pdf.pdf",
      content_type: "application/pdf"
    )
    assert learning_material.save
  end
end
