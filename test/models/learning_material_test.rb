require "test_helper"

class LearningMaterialTest < ActiveSupport::TestCase
  test "should returns false, given invalid file url for learning material" do
    lesson = lessons(:one)
    learning_material = LearningMaterial.new(
      title: "Invalid Material",
      material_type: "video",
      file_url: "invalid_url",
      lesson: lesson
    )

    refute learning_material.valid?
  end

  test "should returns true, given valid file url for learning material" do
    lesson = lessons(:one)
    learning_material = LearningMaterial.new(
      title: "Valid Material",
      material_type: "video",
      file_url: "https://example.com/video.mp4",
      lesson: lesson
    )

    assert learning_material.valid?
  end
end
