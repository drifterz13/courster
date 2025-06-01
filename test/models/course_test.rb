require "test_helper"

class CourseTest < ActiveSupport::TestCase
  test "returns error message, given blank title" do
    course = Course.new(title: "", description: "A sample course", author: users(:one))

    refute course.valid?
    assert_includes course.errors[:title], "can't be blank"
  end

  test "returns error message, given blank description" do
    course = Course.new(title: "Sample Course", description: "", author: users(:one))
    refute course.valid?
    assert_includes course.errors[:description], "can't be blank"
  end

  test "returns error message, given blank author" do
    course = Course.new(title: "Sample Course", description: "A sample course", author: nil)
    refute course.valid?
    assert_includes course.errors[:author], "can't be blank"
  end

  test "returns max_lesson_order, given course with lessons" do
    course = courses(:one)
    assert_equal 2, course.max_lesson_order
  end

  test "returns 0, given course without lessons" do
    course = courses(:no_lessons)
    assert_equal 0, course.max_lesson_order
  end


  test "can_delete_by? returns true for author" do
    course = courses(:one)
    user = users(:one)

    assert course.can_delete_by?(user)
  end

  test "can_delete_by? returns false for non-author" do
    course = courses(:one)
    user = users(:two)

    refute course.can_delete_by?(user)
  end
end
