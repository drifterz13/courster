require "test_helper"

class LessonTest < ActiveSupport::TestCase
  test "should not save lesson without title" do
    course = courses(:course1)
    lesson = Lesson.new(description: "This is a lesson description.", course: course)
    refute lesson.valid?
    assert_includes lesson.errors[:title], "Title can't be blank"
  end

  test "should not save lesson without description" do
    course = courses(:course1)
    lesson = Lesson.new(title: "Lesson Title", course: course)
    refute lesson.valid?
    assert_includes lesson.errors[:description], "Description can't be blank"
  end

  test "should automatically assign order to lesson" do
    course = courses(:course1)

    assert_difference('course.max_lesson_order', 1) do
      next_lesson = course.lessons.create(title: "Next Lesson", description: "Content for next lesson")
      next_lesson.order
    end
  end

  test "should set lesson order correctly for course with lessons" do
    course1 = courses(:course1)
    new_lesson = Lesson.new(title: "New Lesson", description: "Content for new lesson")
    new_lesson.course = course1

    new_lesson.set_lesson_order

    assert new_lesson.valid?
    assert_equal 3, new_lesson.order
  end

  test "can_delete_by? returns true for author" do
    course = courses(:course1)
    lesson = course.lessons.first
    user = users(:user1) # Author user

    assert lesson.can_delete_by?(user)
  end

  test "can_delete_by? returns true for non-author" do
    course = courses(:course1)
    lesson = course.lessons.first
    user = users(:user2) # Non-author user

    refute lesson.can_delete_by?(user)
  end
end
