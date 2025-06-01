require "test_helper"

class LessonTest < ActiveSupport::TestCase
  test "should not save lesson without title" do
    course = courses(:one)
    lesson = Lesson.new(description: "This is a lesson description.", course: course)
    refute lesson.valid?
    assert_includes lesson.errors[:title], "Title can't be blank"
  end

  test "should not save lesson without description" do
    course = courses(:one)
    lesson = Lesson.new(title: "Lesson Title", course: course)
    refute lesson.valid?
    assert_includes lesson.errors[:description], "Description can't be blank"
  end

  test "should automatically assign order to lesson, given course with lessons" do
    course = courses(:one)

    assert_difference('course.max_lesson_order', 1) do
      next_lesson = course.lessons.create(title: "Next Lesson", description: "Content for next lesson")
      next_lesson.order
    end
  end

  test "should automatically assign order to lesson, given course without lessons" do
    course = courses(:no_lessons)

    assert_difference('course.max_lesson_order', 1) do
      next_lesson = course.lessons.create(title: "Next Lesson", description: "Content for next lesson")
      next_lesson.order
    end
  end

  test "should set lesson for course with lessons" do
    course = courses(:one)
    new_lesson = Lesson.new(title: "New Lesson", description: "Content for new lesson")
    new_lesson.course = course

    new_lesson.set_lesson_order

    assert new_lesson.valid?
    assert_equal 3, new_lesson.order
  end

  test "should set lesson for course without lessons" do
    course = courses(:no_lessons)
    new_lesson = Lesson.new(title: "New Lesson", description: "Content for new lesson")
    new_lesson.course = course

    new_lesson.set_lesson_order

    assert new_lesson.valid?
    assert_equal 1, new_lesson.order
  end

  test "can_delete_by? returns true for author" do
    course = courses(:one)
    lesson = course.lessons.first
    user = users(:one) # Author user

    assert lesson.can_delete_by?(user)
  end

  test "can_delete_by? returns true for non-author" do
    course = courses(:one)
    lesson = course.lessons.first
    user = users(:two) # Non-author user

    refute lesson.can_delete_by?(user)
  end

  test "should reject incomplete learning material" do
    course = courses(:one)
    lesson = Lesson.new(title: "Lesson with Material", description: "Content for lesson", course: course)
    
    lesson.learning_material_attributes = { title: "", file_url: "" }

    refute lesson.valid?
    assert_includes lesson.learning_material.errors[:title], "Title can't be blank"
    assert_includes lesson.learning_material.errors[:file_url], "File URL can't be blank"
  end

  test "should save without learning material" do
    course = courses(:one)
    lesson = Lesson.new(title: "Lesson without Material", description: "Content for lesson", course: course)
    assert lesson.valid?
    assert lesson.save
  end
end
