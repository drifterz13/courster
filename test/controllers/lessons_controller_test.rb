require "test_helper"

class LessonsControllerTest < ActionDispatch::IntegrationTest
  test "should render form to create a lesson for course" do
    sign_in users(:user1)
    get new_course_lesson_url(courses(:course1))
    assert_response :success
  end

  test "should create lesson for course" do
    sign_in users(:user1)
    course = courses(:course1)

    assert_difference('Course.with_lessons(course.id).lessons.count', 1) do
        post course_lessons_url(course), params: { lesson: { title: 'New Lesson', description: 'Lesson content' } }
    end
    assert_redirected_to course_path(course)
  end

  test "should not allow to create lesson without login" do
    course = courses(:course1)
    post course_lessons_url(course), params: { lesson: { title: 'New Lesson', description: 'Lesson content', order: 1 } }
    assert_redirected_to new_session_url
  end

  test "should able to delete lesson, given current user is course's author" do
    sign_in users(:user1)
    course = courses(:course1)
    assert_difference('course.lessons.count', -1) do
      delete course_lesson_url(course, course.lessons.first)
    end

    assert_redirected_to course_path(course), notice: 'Lesson was successfully deleted.'
  end

  test "should not able to delete lesson, given current user is not course's author" do
    sign_in users(:user2)
    course = courses(:course1)
    assert_no_difference('course.lessons.count') do
      delete course_lesson_url(course, course.lessons.first)
    end

    assert_redirected_to course_path(course), alert: 'You are not authorized to delete this lesson.'
  end
end
