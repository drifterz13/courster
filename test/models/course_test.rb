require "test_helper"

class CourseTest < ActiveSupport::TestCase
  test "returns error message, given blank title" do
    course = Course.new(title: "", description: "A sample course", author: users(:user1))

    refute course.valid?
    assert_includes course.errors[:title], "Title can't be blank"
  end

  test "returns error message, given blank description" do
    course = Course.new(title: "Sample Course", description: "", author: users(:user1))
    refute course.valid?
    assert_includes course.errors[:description], "Description can't be blank"
  end

  test "returns error message, given blank author" do
    course = Course.new(title: "Sample Course", description: "A sample course", author: nil)
    refute course.valid?
    assert_includes course.errors[:author], "Author can't be blank"
  end

  test "returns max_lesson_order" do
    course = courses(:course1)
    assert_equal 2, course.max_lesson_order
  end

  test "can_delete_by? returns true for author" do
    course = courses(:course1)
    user = users(:user1)

    assert course.can_delete_by?(user)
  end

  test "can_delete_by? returns false for non-author" do
    course = courses(:course1)
    user = users(:user2)

    refute course.can_delete_by?(user)
  end
end
